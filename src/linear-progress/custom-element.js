import { MDCLinearProgress } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcLinearProgress extends HTMLElement {

  get determinate() {
    return this.determinate_;
  }

  set determinate(determinate) {
    this.determinate_ = determinate;
    if (!!this.linearProgress_) {
      this.linearProgress_.determinate = determinate;
    }
  }

  get progress() {
    return this.progress_;
  }

  set progress(progress) {
    this.progress_ = progress;
    if (!!this.linearProgress_) {
      this.linearProgress_.progress = progress;
    }
  }

  get buffer() {
    return this.buffer_;
  }

  set buffer(buffer) {
    this.buffer_ = buffer;
    if (!!this.linearProgress_) {
      this.linearProgress_.buffer = buffer;
    }
  }

  get reverse() {
    return this.reverse_;
  }

  set reverse(reverse) {
    this.reverse_ = reverse
    if (!!this.linearProgress_) {
      this.linearProgress.reverse = reverse_;
    }
  }

  get closed() {
    return this.closed_;
  }

  set closed(closed) {
    this.closed_ = closed;
    if (!!this.linearProgress_) {
      if (closed) {
        this.linearProgress_.close();
      } else {
        this.linearProgress_.open();
      }
    }
  }

  constructor() {
    super();
    this.determinate_ = false;
    this.progress_ = 0;
    this.buffer_ = 0;
    this.reverse_ = false;
    this.closed_ = false;
    this.linearProgress_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.linearProgress_ = new MDCLinearProgress(this);
    this.linearProgress_.determinate = this.determinate_;
    this.linearProgress_.progress = this.progress_;
    this.linearProgress_.buffer = this.buffer_;
    this.linearProgress_.reverse = this.reverse_;
    if (this.closed_) {
      this.linearProgress_.close();
    } else {
      this.linearProgress_.open();
    }
  }

  disconnectedCallback() {
    this.linearProgress_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-linear-progress", MdcLinearProgress);
