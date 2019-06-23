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
    this.mdcRipple = new MDCRipple(this);
  }

  disconnectedCallback() {
    if (typeof this.mdcRipple !== "undefined") {
      this.mdcRipple.destroy();
      delete this.mdcRipple;
    }
  }
};

customElements.define("mdc-list-item", MdcListItem);
