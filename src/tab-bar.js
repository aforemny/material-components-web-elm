import { getClassName, setClassName } from "./utils";
import { MDCTabBarFoundation } from "@material/tab-bar/index";
import { MDCTab } from "@material/tab/index";
import { MDCTabScroller } from "@material/tab-scroller/index";
import { strings, cssClasses } from "@material/tab-bar/constants";

let tabIdCounter = 0;

class MdcTabBar extends HTMLElement {

  static get observedAttributes() {
    return [ "activetab" ];
  }

  get adapter() {
    return {
      scrollTo: scrollX => this.tabScroller_.scrollTo(scrollX),
      incrementScroll: scrollXIncrement =>
        this.tabScroller_.incrementScroll(scrollXIncrement),
      getScrollPosition: () => this.tabScroller_.getScrollPosition(),
      getScrollContentWidth: () => this.tabScroller_.getScrollContentWidth(),
      getOffsetWidth: () => this.offsetWidth,
      isRTL: () => window.getComputedStyle(this).getPropertyValue('direction') === 'rtl',
      setActiveTab: index => {
        if ((index < 0) || (index > this.tabList_.length - 1)) return;
        this.tabList_[index].root_.dispatchEvent(new CustomEvent(
          "MDCTab:interacted",
          {
            detail: { index },
            bubbles: true
          }
        ));
      },
      activateTabAtIndex: (index, clientRect) => {
        if ((index < 0) || (index > this.tabList_.length - 1)) return;
        this.previousIndex_ = index;
        this.tabList_[index].activate(clientRect);
      },
      deactivateTabAtIndex: index => {
        if ((index < 0) || (index > this.tabList_.length - 1)) return;
        this.tabList_[index].deactivate();
      },
      focusTabAtIndex: index => {
        if ((index < 0) || (index > this.tabList_.length - 1)) return;
        this.tabList_[index].focus();
      },
      getTabIndicatorClientRectAtIndex: index => {
        if ((index < 0) || (index > this.tabList_.length - 1)) return;
        return this.tabList_[index].computeIndicatorClientRect();
      },
      getTabDimensionsAtIndex: index => {
        if ((index < 0) || (index > this.tabList_.length - 1)) return;
        return this.tabList_[index].computeDimensions();
      },
      getPreviousActiveTabIndex: () => {
        return this.previousIndex_;
      },
      getFocusedTabIndex: () => {
        const tabElements = this.getTabElements_();
        const activeElement = document.activeElement;
        return tabElements.indexOf(activeElement);
      },
      getIndexOfTabById: (id) => {},
      getTabListLength: () => this.tabList_.length,
      notifyTabActivated: index => {
        this.dispatchEvent(new CustomEvent(
           MDCTabBarFoundation.strings.TAB_ACTIVATED_EVENT,
           {
             detail: { index },
             bubbles: true
           }
        ));
      }
    };
  }

  constructor() {
    super();
    this.className_ = "";
    this.previousIndex_ = -1;
    this.tabScroller_;
    this.tabList_;
    this.handleKeyDown_ = this.handleKeyDown.bind(this);
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    this.foundation_ = new MDCTabBarFoundation(this.adapter);
    this.foundation_.init();

    const tabScrollerElement = this.querySelector(strings.TAB_SCROLLER_SELECTOR);
    this.tabScroller_ = new MDCTabScroller(tabScrollerElement);

    this.tabList_ = this.instantiateTabs();

    this.addEventListener('keydown', this.handleKeyDown_);
    this.foundation_.activateTab(parseInt(this.getAttribute("activetab") || "-1"));
  }

  getTabElements_() {
    return [].slice.call(this.querySelectorAll(MDCTabBarFoundation.strings.TAB_SELECTOR));
  }

  instantiateTabs() {
    return this.getTabElements_().map((el) => {
      el.id = el.id || `mdc-tab-${++tabIdCounter}`;
      el.tabIndex = el.tabIndex || -1;
      return new MDCTab(el);
    });
  }

  handleKeyDown(event) {
    this.foundation_.handleKeyDown(event);
  }

  scrollIntoView(index) {
    this.foundation_.scrollIntoView(index);
  }

  disconnectedCallback() {
    this.foundation_.destroy();
    this.tabScroller_.destroy();
    this.addEventListener("keydown", this.handleKeyDown_);
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.foundation_) return;
    if (name === "activetab") {
      this.foundation_.activateTab(parseInt(this.getAttribute("activetab") || "-1"));
    }
  }
};

customElements.define("mdc-tab-bar", MdcTabBar);
