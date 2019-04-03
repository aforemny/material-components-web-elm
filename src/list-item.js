import { MDCRipple } from '@material/ripple';

class MdcListItem extends HTMLElement {

  constructor() {
    super();
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
