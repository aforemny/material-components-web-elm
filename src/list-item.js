import { getClassName, setClassName } from "./utils";
import { MDCRipple } from '@material/ripple';

class MdcListItem extends HTMLElement {

  constructor() {
    super();
    this.className_ = "";
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    if (this.classList.contains("mdc-list-item")) {
      this.ripple_ = new MDCRipple(this);
    } else {
      this.ripple_ = new MDCRipple(this.querySelector(".mdc-list-item"));
    }
  }

  disconnectedCallback() {
    this.ripple_.destroy();
  }
};

customElements.define("mdc-list-item", MdcListItem);
