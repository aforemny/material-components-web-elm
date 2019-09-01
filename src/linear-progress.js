import { getClassName, setClassName } from "./utils";
import { MDCLinearProgress } from "@material/linear-progress/index";

class MdcLinearProgress extends HTMLElement {

  static get observedAttributes() {
    return [ "determinate", "progress", "buffer", "reverse", "closed" ]
  }

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
    this.linearProgress_ = new MDCLinearProgress(this);
    this.linearProgress_.determinate = this.hasAttribute("determinate");
    this.linearProgress_.progress = parseFloat(this.getAttribute("progress"));
    this.linearProgress_.buffer = parseFloat(this.getAttribute("buffer"));
    this.linearProgress_.reverse = this.hasAttribute("reverse");
    if (this.hasAttribute("closed")) {
      this.linearProgress_.close();
    } else {
      this.linearProgress_.open();
    }
  }

  disconnectedCallback() {
    this.linearProgress_.destroy();
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.linearProgress_) return;
    if (name === "determinate") {
      this.linearProgress_.determinate = this.hasAttribute("determinate");
    } else if (name === "progress") {
      this.linearProgress_.progress = parseFloat(this.getAttribute("progress"));
    } else if (name === "buffer") {
      this.linearProgress_.buffer = parseFloat(this.getAttribute("buffer"));
    } else if (name === "reverse") {
      this.linearProgress_.reverse = this.hasAttribute("reverse");
    } else if (name === "closed") {
      if (this.hasAttribute("closed")) {
        this.linearProgress_.close();
      } else {
        this.linearProgress_.open();
      }
    }
  }
};

customElements.define("mdc-linear-progress", MdcLinearProgress);
