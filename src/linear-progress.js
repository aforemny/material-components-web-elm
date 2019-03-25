import { MDCLinearProgress } from "@material/linear-progress/index";

class MdcLinearProgress extends HTMLElement {

  static get observedAttributes() {
    return [ "determinate", "progress", "buffer", "reverse", "closed" ]
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcLinearProgress = new MDCLinearProgress(this);
    this.mdcLinearProgress.determinate = this.hasAttribute("determinate");
    this.mdcLinearProgress.progress = parseFloat(this.getAttribute("progress"));
    this.mdcLinearProgress.buffer = parseFloat(this.getAttribute("buffer"));
    this.mdcLinearProgress.reverse = this.hasAttribute("reverse");
    if (this.hasAttribute("closed")) {
      this.mdcLinearProgress.close();
    } else {
      this.mdcLinearProgress.open();
    }
  }

  disconnectedCallback() {
    if (this.mdcLinearProgress) {
      this.mdcLinearProgress.destroy();
      delete this.mdcLinearProgress;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcLinearProgress) return;
    if (name === "determinate") {
      this.mdcLinearProgress.determinate = this.hasAttribute("determinate");
    } else if (name === "progress") {
      this.mdcLinearProgress.progress = parseFloat(this.getAttribute("progress"));
    } else if (name === "buffer") {
      this.mdcLinearProgress.buffer = parseFloat(this.getAttribute("buffer"));
    } else if (name === "reverse") {
      this.mdcLinearProgress.reverse = this.hasAttribute("reverse");
    } else if (name === "closed") {
      if (this.hasAttribute("closed")) {
        this.mdcLinearProgress.close();
      } else {
        this.mdcLinearProgress.open();
      }
    }
  }
};

customElements.define("mdc-linear-progress", MdcLinearProgress);
