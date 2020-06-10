import { MDCTopAppBar } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcTopAppBar extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.topAppBar_ = new MDCTopAppBar(this);
  }

  disconnectedCallback() {
    this.topAppBar_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-top-app-bar", MdcTopAppBar);
