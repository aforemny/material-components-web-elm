import { MDCRipple } from "@material/ripple";

class MdcImageListItem extends HTMLElement {
  constructor() {
    super();
    this.ripple_;
  }

  connectedCallback() {
    const rippleSurfaceElement = this.querySelector(".mdc-ripple-surface");
    if (!!rippleSurfaceElement) {
      this.ripple_ = new MDCRipple(rippleSurfaceElement);
    }
  }

  disconnectedCallback() {
    if (!!this.ripple_) {
      this.ripple_.destroy();
    }
  }
};

customElements.define("mdc-image-list-item", MdcImageListItem);
