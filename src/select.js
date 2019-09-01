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
    this.select_ = new MDCSelect(this);
  }

  disconnectedCallback() {
    this.select_.destroy();
  }
};

customElements.define("mdc-select", MdcSelect);
