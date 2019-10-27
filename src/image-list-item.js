import { getClassName, setClassName } from "./utils";
import { MDCRipple } from "@material/ripple";

class MdcImageListItem extends HTMLElement {
  constructor() {
    super();
    this.className_ = "";
    this.ripple_;
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    const element = this.querySelector(".mdc-ripple-surface");
    if (!!element) {
      this.ripple_ = new MDCRipple(element);
    }
  }

  disconnectedCallback() {
    if (!!this.ripple_) {
      this.ripple_.destroy();
    }
  }
};

customElements.define("mdc-image-list-item", MdcImageListItem);
