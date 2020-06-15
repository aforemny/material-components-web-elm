import { MDCTabBar } from "./component";

class MdcTabBar extends HTMLElement {

  focus() {
    for (let i = 0; i < this.tabBar_.tabList_.length; i++) {
      if (this.tabBar_.tabList_[i].active) {
        this.tabBar_.tabList_[i].focus();
        return;
      }
    }
    if (this.tabBar_.tabList[0].length > 0) {
      this.tabBar_.tabList_[0].focus();
    }
  }

  blur() {
    if (this.contains(document.activeElement)) {
      document.activeElement.blur();
    }
  }

  get focusOnActivate() {
    return this.focusOnActivate_;
  }

  set focusOnActivate(focusOnActivate) {
    this.focusOnActivate_ = focusOnActivate;
    if (!!this.tabBar_) {
      this.tabBar_.focusOnActivate = focusOnActivate;
    }
  }

  get useAutomaticActivation() {
    return this.useAutomaticActivation_;
  }

  set useAutomaticActivation(useAutomaticActivation) {
    this.useAutomaticActivation_ = useAutomaticActivation;
    if (!!this.tabBar_) {
      this.tabBar_.useAutomaticActivation = useAutomaticActivation;
    }
  }

  get activeTabIndex() {
    return this.activeTabIndex_;
  }

  set activeTabIndex(activeTabIndex) {
    const previousActiveTabIndex = this.activeTabIndex_;
    this.activeTabIndex_ = activeTabIndex;
    if (!!this.tabBar_) {
      if (previousActiveTabIndex !== -1) {
        this.tabBar_.foundation_.activateTab(activeTabIndex);
      } else {
        this.tabBar_.tabList_[activeTabIndex].activate();
      }
    }
  }

  constructor() {
    super();
    this.activeTabIndex_ = -1;
    this.focusOnActivate_ = false;
    this.useAutomaticActivation_ = false;
    this.tabBar_;
  }

  connectedCallback() {
    this.tabBar_ = new MDCTabBar(this);
    this.tabBar_.focusOnActivate = this.focusOnActivate_;
    this.tabBar_.useAutomaticActivation = this.useAutomaticActivation_;
    if (this.activeTabIndex !== -1) {
      this.tabBar_.tabList_[this.activeTabIndex_].activate();
    }
  }

  disconnectedCallback() {
    this.tabBar_.destroy();
  }
};

customElements.define("mdc-tab-bar", MdcTabBar);
