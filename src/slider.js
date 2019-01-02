import { MDCSlider } from "@material/slider/index";

class MdcSlider extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCSlider = new MDCSlider(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCSlider !== "undefined") {
      this.MDCSlider.destroy();
      delete this.MDCSlider;
    }
  }
};

customElements.define("mdc-slider", MdcSlider);
