import { getClassName, setClassName } from "./utils";
import { matches } from "@material/dom/ponyfill";
import { MDCListFoundation } from "@material/list/index";

class MdcList extends HTMLElement {

  constructor() {
    super();
    this.className_ = "";
    this.handleKeydown_ = this.handleKeydown.bind(this);
    this.handleFocusIn_ = this.handleFocusIn.bind(this);
    this.handleFocusOut_ = this.handleFocusOut.bind(this);
  }

  connectedCallback() {
    this.foundation_ = new MDCListFoundation(this.getAdapter_());
    this.foundation_.init();
    this.style.display = "block";

    this.addEventListener("keydown", this.handleKeydown_);
    this.addEventListener("focusin", this.handleFocusIn_);
    this.addEventListener("focusout", this.handleFocusOut_);

    this.layout();
  }

  disconnectedCallback() {
    this.foundation_.destroy();

    this.removeEventListener("keydown", this.handleKeydown_);
    this.removeEventListener("focusin", this.focusInEventListener_);
    this.removeEventListener("focusout", this.focusOutEventListener_);
  }

  getAdapter_() {
    return {
      getListItemCount: () => this.listElements.length,
      getFocusedElementIndex: () => this.listElements.indexOf(document.activeElement),
      setAttributeForElementIndex: (index, attr, value) => {
        const element = this.listElements[index];
        if (element) {
          element.setAttribute(attr, value);
        }
      },
      removeAttributeForElementIndex: (index, attr) => {
        const element = this.listElements[index];
        if (element) {
          element.removeAttribute(attr);
        }
      },
      addClassForElementIndex: (index, className) => {
        const element = this.listElements[index];
        if (element) {
          element.classList.add(className);
        }
      },
      removeClassForElementIndex: (index, className) => {
        const element = this.listElements[index];
        if (element) {
          element.classList.remove(className);
        }
      },
      focusItemAtIndex: (index) => {
        const element = this.listElements[index];
        if (element) {
          element.focus();
        }
      },
      setTabIndexForListItemChildren: (listItemIndex, tabIndexValue) => {
        const element = this.listElements[listItemIndex];
        const listItemChildren = [].slice.call(element.querySelectorAll(
          MDCListFoundation.strings.CHILD_ELEMENTS_TO_TOGGLE_TABINDEX)
        );
        listItemChildren.forEach((ele) => ele.setAttribute('tabindex', tabIndexValue));
      },
      followHref: (index) => {
        const listItem = this.listElements[index];
        if (listItem && listItem.href) {
          listItem.click();
        }
      },
      hasCheckboxAtIndex: (index) => {
        const listItem = this.listElements[index];
        return !!listItem.querySelector(MDCListFoundation.strings.CHECKBOX_SELECTOR);
      },
      hasRadioAtIndex: (index) => {
        const listItem = this.listElements[index];
        return !!listItem.querySelector(MDCListFoundation.strings.RADIO_SELECTOR);
      },
      isCheckboxCheckedAtIndex: (index) => {
        const listItem = this.listElements[index];
        const toggleEl = listItem.querySelector(
          MDCListFoundation.strings.CHECKBOX_SELECTOR
        );
        return toggleEl.checked;
      },
      setCheckedCheckboxOrRadioAtIndex: (index, isChecked) => {
        const listItem = this.listElements[index];
        const toggleEl = listItem.querySelector(
          MDCListFoundation.strings.CHECKBOX_RADIO_SELECTOR
        );
        toggleEl.checked = isChecked;

        const event = document.createEvent('Event');
        event.initEvent('change', true, true);
        toggleEl.dispatchEvent(event);
      },
      isFocusInsideList: () => {
        return this.contains(document.activeElement);
      },
    };
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  get listElements() {
    return [].slice.call(this.querySelectorAll(
      MDCListFoundation.strings.ENABLED_ITEMS_SELECTOR)
    );
  }

  handleFocusIn(event) {
    const index = this.getListItemIndex(event);
    this.foundation_.handleFocusIn(event, index);
  }

  handleFocusOut(event) {
    const index = this.getListItemIndex(event);
    this.foundation_.handleFocusOut(event, index);
  }

  handleKeydown(event) {
    const isEnter = event.key === 'Enter' || event.keyCode === 13;
    const isSpace = event.key === 'Space' || event.keyCode === 32;
    if (isEnter || isSpace) return;

    const index = this.getListItemIndex(event);
    if (index >= 0) {
      this.foundation_.handleKeydown(
        event,
        event.target.classList.contains("mdc-list-item"),
        index);
    }
  }

  layout() {
    const direction = this.getAttribute(MDCListFoundation.strings.ARIA_ORIENTATION);
    const vertical = direction !== MDCListFoundation.strings.ARIA_ORIENTATION_HORIZONTAL;
    this.foundation_.setVerticalOrientation(vertical);

    if (this.querySelector('.mdc-list-item--selected, .mdc-list-item--activated')) {
      this.querySelector('.mdc-list-item--selected, .mdc-list-item--activated')
        .setAttribute('tabindex', 0);
    } else {
      if (this.querySelector('.mdc-list-item')) {
        this.querySelector('.mdc-list-item').setAttribute('tabindex', 0);
      }
    }

    [].slice.call(this.querySelectorAll('.mdc-list-item:not([tabindex])'))
      .forEach(element => element.setAttribute('tabindex', -1));

    [].slice.call(
      this.querySelectorAll(MDCListFoundation.strings.FOCUSABLE_CHILD_ELEMENTS)
    )
      .forEach(element => element.setAttribute('tabindex', -1));

    this.foundation_.layout();
  }

  getListItemIndex(event) {
    let eventTarget = event.target;
    let index = -1;

    while (!eventTarget.classList.contains("mdc-list-item") &&
      !eventTarget.classList.contains("mdc-list")) {
      eventTarget = eventTarget.parentElement;
    }

    if (eventTarget.classList.contains("mdc-list-item")) {
      index = this.listElements.indexOf(eventTarget);
    }

    return index;
  }
};

customElements.define("mdc-list", MdcList);
