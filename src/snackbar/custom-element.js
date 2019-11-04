import { MDCSnackbar } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcSnackbar extends HTMLElement {

  get closeOnEscape() {
    return this.closeOnEscape_;
  }

  set closeOnEscape(closeOnEscape) {
    this.closeOnEscape_ = closeOnEscape;
    if (!!this.snackbar_) {
      this.snackbar_.closeOnEscape = closeOnEscape;
    }
  }

  get timeoutMs() {
    return this.timeoutMs_;
  }

  set timeoutMs(timeoutMs) {
    this.timeoutMs_ = timeoutMs;
    if (!!this.snackbar_) {
      this.snackbar_.timeoutMs = timeoutMs;
    }
  }

  get messageId() {
    return this.messageId_;
  }

  set messageId(messageId) {
    this.messageId_ = messageId;
    if (!!this.snackbar_ && !!messageId) {
      this.snackbar_.open();
    }
  }

  constructor() {
    super();
    this.closeOnEscape_ = false;
    this.timeoutMs_ = 5000;
    this.messageId_ = 0;
    this.snackbar_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.snackbar_ = new MDCSnackbar(this);
    this.snackbar_.closeOnEscape = this.closeOnEscape_;
    this.snackbar_.timeoutMs = this.timeoutMs_;
    if (!!this.messageId_) {
      this.snackbar_.open();
    }
  }

  disconnectedCallback() {
    this.snackbar_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-snackbar", MdcSnackbar);
