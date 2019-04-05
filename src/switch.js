import { MDCSwitch } from "@material/switch/index";

class MdcSwitch extends HTMLElement {

  static get observedAttributes() {
    return ["checked", "disabled"];
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.switch_ = new MDCSwitch(this);
    this.setChecked_();
    this.setDisabled_();
  }

  disconnectedCallback() {
    this.switch_.destroy();
  }

  setChecked_() {
    this.switch_.checked = this.hasAttribute("checked");
  }

  setDisabled_() {
    this.switch_.disabled = this.hasAttribute("disabled");
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.switch_) return;
    if (name === "checked") {
      this.setChecked_();
    } else if (name === "disabled") {
      this.setDisabled_();
    }
  }

  get input() {
    return this.switch_;
  }
};

customElements.define("mdc-switch", MdcSwitch);
