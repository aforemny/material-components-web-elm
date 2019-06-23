import { getClassName, setClassName } from "./utils";
import { MDCSelect } from "@material/select/index";

class MdcSelect extends HTMLElement {

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

  get root_() {
    return this;
  }

  connectedCallback() {
    this.MDCSelect = new MDCSelect(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCSelect !== "undefined") {
      this.MDCSelect.destroy();
      delete this.MDCSelect;
    }
  }
};

customElements.define("mdc-select", MdcSelect);
