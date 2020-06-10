import { MDCSelect } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcSelect extends HTMLElement {

  get value() {
    if (!!this.select_) {
      return this.select_.value;
    } else {
      return this.value_;
    }
  }

  set value(value) {
    this.value_ = value;
    if (!!this.select_) {
      this.select_.value = value;
    }
  }

  get disabled() {
    return this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
    if (!!this.select_) {
      this.select_.disabled = disabled;
    }
  }

  get required() {
    return this.required_;
  }

  set required(required) {
    this.required_ = required;
    if (!!this.select_) {
      this.select_.required = required;
    }
  }

  constructor() {
    super();
    this.value_ = "";
    this.disabled_ = false;
    this.required_ = false;
    this.select_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.select_ = new MDCSelect(this);
    this.select_.value = this.value_;
    this.select_.disabled = this.disabled_;
    this.select_.required = this.required_;
  }

  disconnectedCallback() {
    this.select_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-select", MdcSelect);
