import { MDCCircularProgress } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcCircularProgress extends HTMLElement {

  get determinate() {
    return this.determinate_;
  }

  set determinate(determinate) {
    this.determinate_ = determinate;
    if (!!this.circularProgress_) {
      this.circularProgress_.determinate = determinate;
    }
  }

  get progress() {
    return this.progress_;
  }

  set progress(progress) {
    this.progress_ = progress;
    if (!!this.circularProgress_) {
      this.circularProgress_.progress = progress;
    }
  }

  get closed() {
    return this.closed_;
  }

  set closed(closed) {
    this.closed_ = closed;
    if (!!this.circularProgress_) {
      if (closed) {
        this.circularProgress_.close();
      } else {
        this.circularProgress_.open();
      }
    }
  }

  constructor() {
    super();
    this.determinate_ = false;
    this.progress_ = 0;
    this.closed_ = false;
    this.circularProgress_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.circularProgress_ = new MDCCircularProgress(this);
    this.circularProgress_.determinate = this.determinate_;
    this.circularProgress_.progress = this.progress_;
    if (this.closed_) {
      this.circularProgress_.close();
    } else {
      this.circularProgress_.open();
    }
  }

  disconnectedCallback() {
    this.circularProgress_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-circular-progress", MdcCircularProgress);
