import { MDCRadio } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcRadio extends HTMLElement {

  get checked() {
    return this.checked_;
  }

  set checked(checked) {
    this.checked_ = checked;
    if (!!this.radio_) {
      this.radio_.checked = checked;
    }
  }

  get disabled() {
    return this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
    if (!!this.radio_) {
      this.radio_.disabled = disabled;
    }
  }

  constructor() {
    super();
    this.checked_ = false;
    this.disabled_ = false;
    this.radio_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.radio_ = new MDCRadio(this);
    this.radio_.checked = this.checked_;
    this.radio_.disabled = this.disabled_;
  }

  disconnectedCallback() {
    this.radio_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-radio", MdcRadio);
