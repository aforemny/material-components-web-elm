import { getClassName, setClassName } from "./utils";
import { MDCMenuFoundation } from "@material/menu/index";
import { MDCMenuSurface, MDCMenuSurfaceFoundation } from "@material/menu-surface/index";
import { strings, cssClasses } from "@material/menu/constants";

class MdcMenu extends HTMLElement {

  static get observedAttributes() {
    return [ "open", "quickOpen" ];
  }

  constructor() {
    super();
    this.className_ = "";
    this.handleKeydown_ = this.handleKeydown.bind(this);
    this.handleClick_ = this.handleClick.bind(this);
    this.afterOpenedCallback_ = this.afterOpenedCallback.bind(this);
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  handleKeydown(event) {
    this.mdcFoundation.handleKeydown(event);
  }

  handleClick(event) {
    this.mdcFoundation.handleClick(event);
  }

  afterOpenedCallback(event) {
    const list = this.items;
    if (list.length > 0) {
      list[0].focus();
    }
  }

  get items() {
    return this.querySelector(".mdc-list").listElements;
  }

  get adapter() {
    return {
      addClassToElementAtIndex: (index, className) => {
        const list = this.items;
        list[index].classList.add(className);
      },
      removeClassFromElementAtIndex: (index, className) => {
        const list = this.items;
        list[index].classList.remove(className);
      },
      addAttributeToElementAtIndex: (index, attr, value) => {
        const list = this.items;
        list[index].setAttribute(attr, value);
      },
      removeAttributeFromElementAtIndex: (index, attr) => {
        const list = this.items;
        list[index].removeAttribute(attr);
      },
      elementContainsClass: (element, className) => element.classList.contains(className),
      closeSurface: () => this.open = false,
      getElementIndex: element => this.items.indexOf(element),
      getParentElement: element => element.parentElement,
      getSelectedElementIndex: selectionGroup => {
        return this.items.indexOf(
          selectionGroup.querySelector(`.${cssClasses.MENU_SELECTED_LIST_ITEM}`)
        );
      },
      notifySelected: evtData => this.dispatchEvent(new CustomEvent(
        strings.SELECTED_EVENT, {
        index: evtData.index,
        item: this.items[evtData.index],
      }))
    };
  }

  connectedCallback() {
    this.anchorElement = this.parentElement;

    this.mdcMenuSurface = new MDCMenuSurface(this);

    this.mdcMenuSurface.foundation_.doClose = this.mdcMenuSurface.foundation_.close;
    this.mdcMenuSurface.foundation_.close = () => {
      this.dispatchEvent(new CustomEvent("MDCMenu:close"));
    };

    this.mdcFoundation = new MDCMenuFoundation(this.adapter);
    this.mdcFoundation.init();

    this.mdcMenuSurface.listen(
      MDCMenuSurfaceFoundation.strings.OPENED_EVENT,
      this.afterOpenedCallback_
    );
    this.addEventListener("keydown", this.handleKeydown_);
    this.addEventListener("click", this.handleClick_);

    this.mdcMenuSurface.quickOpen = this.hasAttribute("quickopen");
    if (this.hasAttribute("open")) {
      this.mdcMenuSurface.open = true;
    }
  }

  disconnectedCallback() {
    if (this.mdcFoundation) {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }

    if (this.mdcMenuSurface) {
      this.mdcMenuSurface.destroy();
      this.mdcMenuSurface.unlisten(
        MDCMenuSurfaceFoundation.strings.OPENED_EVENT,
        this.afterOpenedCallback_
      );
      delete this.mdcMenuSurface;
    }
    this.removeEventListener("keydown", this.handleKeydown_);
    this.removeEventListener("click", this.handleClick_);
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcMenuSurface) return;
    if (name === "open") {
      if (this.hasAttribute("open")) {
        this.mdcMenuSurface.open = true;
      } else {
        this.mdcMenuSurface.foundation_.doClose();
      }
    } else if (name === "quickopen") {
      this.mdcMenuSurface.quickOpen = this.hasAttribute("quickopen");
    }
  }
};

customElements.define("mdc-menu", MdcMenu);
