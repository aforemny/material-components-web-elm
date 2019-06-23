import { getClassName, setClassName } from "./utils";
import { MDCChipSet } from "@material/chips/index";

class MdcChipSet extends HTMLElement {

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
  }

  disconnectedCallback() {
  }
};

customElements.define("mdc-chip-set", MdcChipSet);
