import { MDCLinearProgress } from "@material/linear-progress/index";

class MdcLinearProgress extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCLinearProgress = new MDCLinearProgress(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCLinearProgress !== "undefined") {
      this.MDCLinearProgress.destroy();
      delete this.MDCLinearProgress;
    }
  }
};

customElements.define("mdc-linear-progress", MdcLinearProgress);
