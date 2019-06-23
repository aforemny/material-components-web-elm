import { getClassName, setClassName } from "./utils";
import { MDCTopAppBar } from "@material/top-app-bar/index";

class MdcTopAppBar extends HTMLElement {

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
    this.mdcComponent = new MDCTopAppBar(this);
  }

  disconnectedCallback() {
    this.mdcComponent.destroy();
  }
};

customElements.define("mdc-top-app-bar", MdcTopAppBar);
