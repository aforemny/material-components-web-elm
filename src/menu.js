import { getClassName, setClassName } from "./utils";
import { MDCListFoundation } from "@material/list/index";
import { MDCMenuFoundation } from "@material/menu/index";
import { MDCMenuSurface, MDCMenuSurfaceFoundation } from "@material/menu-surface/index";
import { strings, cssClasses } from "@material/menu/constants";

class MdcMenu extends HTMLElement {

  static get observedAttributes() {
    return [ "open", "quickOpen" ];
  }

  constructor() {
    super();
    this.root_;
    this.className_ = "";
    this.foundation_;
    this.menuSurface_;
    this.handleKeydown_;
    this.handleItemAction_;
    this.afterOpenedCallback_;
  }

  get list_() {
    const listElement = this.root_.querySelector(strings.LIST_SELECTOR);
    return listElement.foundation_;
  }

  connectedCallback() {
    this.root_ = this;

    this.menuSurface_ = new MDCMenuSurface(this.root_);
    this.menuSurface_.foundation_.doClose = this.menuSurface_.foundation_.close;
    this.menuSurface_.foundation_.close = () => {
      if (this.hasAttribute("open")) {
        this.root_.dispatchEvent(new CustomEvent("MDCMenu:close"));
      }
    };

    this.handleKeydown_ = event => this.foundation_.handleKeydown(event);
    this.handleItemAction_ = event =>
      this.foundation_.handleItemAction(this.getItems_()[event.detail]);
    this.afterOpenedCallback_ = () => this.handleAfterOpened_();

    this.menuSurface_.listen(MDCMenuSurfaceFoundation.strings.OPENED_EVENT, this.afterOpenedCallback_);
    this.addEventListener("keydown", this.handleKeydown_);
    this.addEventListener(MDCListFoundation.strings.ACTION_EVENT, this.handleItemAction_);

    this.foundation_ = new MDCMenuFoundation(this.getAdapter_());
    this.foundation_.init();

    this.menuSurface_.quickOpen = this.hasAttribute("quickopen");
    this.menuSurface_.open = this.hasAttribute("open");
  }

  disconnectedCallback() {
    this.menuSurface_.destroy();
    this.menuSurface_.unlisten(MDCMenuSurfaceFoundation.strings.OPENED_EVENT, this.afterOpenedCallback_);
    this.removeEventListener("keydown", this.handleKeydown_);
    this.removeEventListener(MDCListFoundation.strings.ACTION_EVENT, this.handleItemAction_);

    this.foundation_.destroy();
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.menuSurface_) return;
    if (name === "open") {
      if (this.hasAttribute("open")) {
        this.menuSurface_.open = true;
      } else {
        this.menuSurface_.foundation_.doClose();
      }
    } else if (name === "quickopen") {
      this.menuSurface_.quickOpen = this.hasAttribute("quickopen");
    }
  }

  getAdapter_() {
    return {
      addClassToElementAtIndex: (index, className) => {
        const list = this.getItems_();
        list[index].classList.add(className);
      },
      removeClassFromElementAtIndex: (index, className) => {
        const list = this.getItems_();
        list[index].classList.remove(className);
      },
      addAttributeToElementAtIndex: (index, attr, value) => {
        const list = this.getItems_();
        list[index].setAttribute(attr, value);
      },
      removeAttributeFromElementAtIndex: (index, attr) => {
        const list = this.getItems_();
        list[index].removeAttribute(attr);
      },
      elementContainsClass: (element, className) => element.classList.contains(className),
      closeSurface: () => this.menuSurface_.open = false,
      getElementIndex: element => this.getItems_().indexOf(element),
      getParentElement: element => element.parentElement,
      getSelectedElementIndex: selectionGroup => {
        return this.getItems_().indexOf(
          selectionGroup.querySelector(`.${cssClasses.MENU_SELECTED_LIST_ITEM}`)
        );
      },
      notifySelected: evtData => this.dispatchEvent(new CustomEvent(
        strings.SELECTED_EVENT, {
          detail: {
            index: evtData.index,
            item: this.getItems_()[evtData.index],
          }
      }))
    };
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  handleAfterOpened_(event) {
    const list = this.getItems_();
    if (list.length > 0) {
      list[0].focus();
    }
  }

  getItems_() {
    return this.querySelector(".mdc-list").listElements;
  }
};

customElements.define("mdc-menu", MdcMenu);
