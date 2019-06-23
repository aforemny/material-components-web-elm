import { MDCRadio } from "@material/radio/index";
import { getClassName, setClassName } from "./utils";

class MdcRadio extends HTMLElement {

  static get observedAttributes() {
    return ["checked", "disabled"];
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
    this.radio_ = new MDCRadio(this);
    this.setChecked_();
    this.setDisabled_();
  }

  disconnectedCallback() {
    this.radio_.destroy();
  }

  setChecked_() {
    this.radio_.checked = this.hasAttribute("checked");
  }

  setDisabled_() {
    this.radio_.disabled = this.hasAttribute("disabled");
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.radio_) return;
    if (name === "checked") {
      this.setChecked_();
    } else if (name === "disabled") {
      this.setDisabled_();
    }
  }

  get input() {
    return this.radio_;
  }
};

customElements.define("mdc-radio", MdcRadio);
