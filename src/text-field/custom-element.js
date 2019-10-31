import { MDCTextField } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcTextField extends HTMLElement {

  get value() {
    if (!!this.textField_) {
      return this.textField_.value;
    } else {
      return this.value_;
    }
  }

  set value(value) {
    this.value_ = value;
    if (!!this.textField_) {
      this.textField_.value = value;
    }
  }

  get disabled() {
    return this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
    if (!!this.textField_) {
      this.textField_.disabled = disabled;
    }
  }

  get valid() {
    return this.valid_;
  }

  set valid(valid) {
    this.valid_ = valid;
    if (!!this.textField_) {
      this.textField_.valid = valid;
    }
  }

  get required() {
    return this.required_;
  }

  set required(required) {
    this.required_ = required;
    if (!!this.textField_) {
      this.required_ = required;
    }
  }

  get pattern() {
    return this.pattern_;
  }

  set pattern(pattern) {
    this.pattern_ = pattern;
    if (!!this.textField_) {
      this.textField_.pattern = pattern;
    }
  }

  get minLength() {
    return this.minLength_;
  }

  set minLength(minLength) {
    this.minLength_ = minLength;
    if (!!this.textField) {
      this.textField_.minLength = minLength;
    }
  }

  get maxLength() {
    return this.maxLength_;
  }

  set maxLength(maxLength) {
    this.maxLength_ = maxLength;
    if (!!this.textField_) {
      this.textField_.maxLength = maxLength;
    }
  }

  get min() {
    return this.min_;
  }

  set min(min) {
    this.min_ = min;
    if (!!this.textField_) {
      this.textField_.min = min;
    }
  }

  get max() {
    return this.max_;
  }

  set max(max) {
    this.max_ = max;
    if (!!this.textField_) {
      this.textField_.max = max;
    }
  }

  get step() {
    return this.step_;
  }

  set step(step) {
    this.step_ = step;
    if (!!this.textField_) {
      this.textField_.step = step;
    }
  }

  constructor() {
    super();
    this.value_ = "";
    this.disabled_ = false;
    this.valid_ = true;
    this.required_ = false;
    this.pattern_ = "";
    this.minLength_ = -1;
    this.maxLength_ = -1;
    this.min_ = "";
    this.max_ = "";
    this.step_ = "";
    this.textField_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.textField_ = new MDCTextField(this);
    this.textField_.useNativeValidation = false;
    this.textField_.value = this.value_;
    this.textField_.disabled = this.disabled_;
    this.textField_.valid = this.valid_;
    this.textField_.required = this.required_;
    this.textField_.pattern = this.pattern_;
    this.textField_.minLength = this.minLength_;
    this.textField_.maxLength = this.maxLength_;
    this.textField_.min = this.min_;
    this.textField_.max = this.max_;
    this.textField_.step = this.step_;
  }

  disconnectedCallback() {
    this.textField_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-text-field", MdcTextField);
