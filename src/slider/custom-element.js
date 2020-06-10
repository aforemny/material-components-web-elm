import { MDCSlider } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcSlider extends HTMLElement {

  get value() {
    if (!!this.slider_) {
      return this.slider_.value;
    } else {
      return this.value_;
    }
  }

  set value(value) {
    this.value_ = value;
    if (!!this.slider_) {
      this.slider_.value = value;
    }
  }

  get min() {
    return this.min_;
  }

  set min(min) {
    this.min_ = min;
    if (!!this.slider_) {
      this.slider_.min = min;
    }
  }

  get max() {
    return this.max_;
  }

  set max(max) {
    this.max_ = max;
    if (!!this.slider_) {
      this.slider_.max = max;
    }
  }

  get step() {
    return this.step_;
  }

  set step(step) {
    this.step_ = step;
    if (!!this.slider_) {
      this.slider_.step = step;
    }
  }

  get disabled() {
    return this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
    if (!!this.slider_) {
      this.slider_.disabled = disabled;
    }
  }

  constructor() {
    super();
    this.value_ = 0;
    this.min_ = 0;
    this.max_ = 100;
    this.step_ = 0;
    this.disabled_ = false;
    this.slider_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.slider_ = new MDCSlider(this);
    this.slider_.value = this.value_;
    this.slider_.min = this.min_;
    this.slider_.max = this.max_;
    this.slider_.step = this.step_;
    this.slider_.disabled = this.disabled_;
  }

  disconnectedCallback() {
    this.slider_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-slider", MdcSlider);
