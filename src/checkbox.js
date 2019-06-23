import { getClassName, setClassName } from "./utils";
import { MDCCheckbox } from "@material/checkbox/index";

class MdcCheckbox extends HTMLElement {

  static get observedAttributes() {
    return [ "state", "disabled" ];
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
    this.checkbox_ = new MDCCheckbox(this);
    this.setState_();
    this.setDisabled_();
  }

  disconnectedCallback() {
    this.checkbox_.destroy();
  }

  setState_() {
    const state = this.getAttribute("state");
    this.checkbox_.checked = state === "checked";
    this.checkbox_.indeterminate = state === "indeterminate";
  }

  setDisabled_() {
    this.checkbox_.disabled = this.hasAttribute("disabled");
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.checkbox_) return;
    if (name === "state") {
      this.setState_();
    } else if (name === "disabled") {
      this.setDisabled_();
    }
  }

  get input() {
    return this.checkbox_;
  }
}

customElements.define("mdc-checkbox", MdcCheckbox);
