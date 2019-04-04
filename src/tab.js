import { MDCTab } from "@material/tab/index";

class MdcTab extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCTab = new MDCTab(this);
  }

  activate(previousIndicatorClientRect) {
    if (!this.MDCTab) return;
    return this.MDCTab.activate(previousIndicatorClientRect);
  }

  deactivate() {
    if (!this.MDCTab) return;
    return this.MDCTab.deactivate();
  }

  computeIndicatorClientRect() {
    if (!this.MDCTab) return;
    return this.MDCTab.computeIndicatorClientRect();
  }

  computeDimensions() {
    if (!this.MDCTab) return;
    return this.MDCTab.computeDimensions();
  }

  disconnectedCallback() {
    if (typeof this.MDCTab !== "undefined") {
      this.MDCTab.destroy();
      delete this.MDCTab;
    }
  }
};

customElements.define("mdc-tab", MdcTab);
