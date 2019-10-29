import { MDCCheckbox } from './component';
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcCheckbox extends HTMLElement {

  get checked() {
    return this.checked_;
  }

  set checked(checked) {
    this.checked_ = checked;
    if (!!this.checkbox_) {
      this.checkbox_.checked = checked;
    }
  }

  get indeterminate() {
    return this.indeterminate_;
  }

  set indeterminate(indeterminate) {
    this.indeterminate_ = indeterminate;
    if (!!this.checkbox_) {
      this.checkbox_.indeterminate = indeterminate;
    }
  }

  get disabled() {
    return this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
    if (!!this.checkbox_) {
      this.checkbox_.disabled = disabled;
    }
  }

  constructor() {
    super();
    this.checked_ = false;
    this.indeterminate_ = false;
    this.disabled_ = false;
    this.checkbox_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.checkbox_ = new MDCCheckbox(this);
    this.checkbox_.checked = this.checked_;
    this.checkbox_.indeterminate = this.indeterminate_;
    this.checkbox_.disabled = this.disabled_;
  }

  destroy()  {
    this.checkbox_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
}

customElements.define("mdc-checkbox", MdcCheckbox);
