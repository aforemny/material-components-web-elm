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
    this.ripple_ = new MDCRipple(this);
  }

  disconnectedCallback() {
    this.ripple_.destroy();
  }
};

customElements.define("mdc-list-item", MdcListItem);
