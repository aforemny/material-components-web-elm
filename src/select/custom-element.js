import { MDCSelect } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcSelect extends HTMLElement {

  focus() {
    this.select_.selectAnchor.focus();
  }

  blur() {
    this.select_.selectAnchor.blur();
  }

  get selectedIndex() {
    return !!this.select_ ? this.select_.selectedIndex : this.selectedIndex_;
  }

  set selectedIndex(selectedIndex) {
    this.selectedIndex_ = selectedIndex;
    if (!!this.select_) this.select_.selectedIndex = selectedIndex;
  }

  get disabled() {
    return !!this.select_ ? this.select_.disabled : this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
    if (!!this.select_) this.select_.disabled = disabled;
  }

  get valid() {
    return !!this.select_ ? this.select_.valid : this.valid_;
  }

  set valid(valid) {
    this.valid_ = valid;
    if (!!this.select_) this.select_.valid = valid;
  }

  get required() {
    return !!this.select_ ? this.select_.required : this.required_;
  }

  set required(required) {
    this.required_ = required;
    if (!!this.select_) this.select_.required = required;
  }

  constructor() {
    super();
    this.selectedIndex_ = -1;
    this.disabled_ = false;
    this.valid_ = true;
    this.required_ = false;
    this.select_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.select_ = new MDCSelect(this);
    this.select_.disabled = this.disabled_;
    this.select_.valid = this.valid_;
    this.select_.required = this.required_;
  }

  menuSetup(menuElement) {
    this.select_.menuSetup(menuElement);
    this.select_.selectedIndex = this.selectedIndex_;
  }

  disconnectedCallback() {
    this.select_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-select", MdcSelect);
