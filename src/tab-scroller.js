import { MDCTabScroller } from "@material/tab-scroller/index";

class MdcTabScroller extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCTabScroller = new MDCTabScroller(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCTabScroller !== "undefined") {
      this.MDCTabScroller.destroy();
      delete this.MDCTabScroller;
    }
  }
};

customElements.define("mdc-tab-scroller", MdcTabScroller);
