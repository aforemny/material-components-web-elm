import { MDCTabBarFoundation } from "@material/tab-bar/index";
import { MDCTabFoundation } from "@material/tab/index";
import { MDCTabScroller } from "@material/tab-scroller/index";
import { strings, cssClasses } from "@material/tab-bar/constants";

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
      setActiveTab: index => this.foundation_.activateTab(index),
      activateTabAtIndex: (index, clientRect) => {
        const tabList = this.tabList_;
        if ((index < 0) || (index > tabList.length - 1)) return;
        this.previousIndex_ = index;
        tabList[index].activate(clientRect);
      },
      deactivateTabAtIndex: index => {
        const tabList = this.tabList_;
        if ((index < 0) || (index > tabList.length - 1)) return;
        tabList[index].deactivate();
      },
      focusTabAtIndex: index => {
        const tabList = this.tabList_;
        if ((index < 0) || (index > tabList.length - 1)) return;
        tabList[index].focus();
      },
      getTabIndicatorClientRectAtIndex: index => {
        const tabList = this.tabList_;
        if ((index < 0) || (index > tabList.length - 1)) return;
        return tabList[index].computeIndicatorClientRect();
      },
      getTabDimensionsAtIndex: index => {
        const tabList = this.tabList_;
        if ((index < 0) || (index > tabList.length - 1)) return;
        return tabList[index].computeDimensions();
      },
      getPreviousActiveTabIndex: () => {
        return this.previousIndex_;
      },
      getFocusedTabIndex: () => {
        const tabElements = this.tabList_;
        const activeElement = document.activeElement;
        return tabElements.indexOf(activeElement);
      },
      getIndexOfTabById: (id) => {},
      getTabListLength: () => this.tabList_.length,
      notifyTabActivated: index => {
        this.dispatchEvent(new CustomEvent(
           MDCTabBarFoundation.strings.TAB_ACTIVATED_EVENT,
           {
             detail: {index},
             bubbles: true
           }
        ));
      }
    };
  }

  constructor() {
    super();
    this.previousIndex_ = -1;
    this.tabScroller_;
    this.handleKeyDown_ = this.handleKeyDown.bind(this);
  }

  get tabList_() {
    return [].slice.call(this.querySelectorAll(MDCTabBarFoundation.strings.TAB_SELECTOR));
  }

  connectedCallback() {
    this.foundation_ = new MDCTabBarFoundation(this.adapter);
    this.foundation_.init();
    console.log(this.foundation_);

    const tabScrollerElement = this.querySelector(strings.TAB_SCROLLER_SELECTOR);
    this.tabScroller_ = new MDCTabScroller(tabScrollerElement);

    this.addEventListener('keydown', this.handleKeyDown_);

    window.requestAnimationFrame(() => {
      this.foundation_.activateTab(parseInt(this.getAttribute("activetab") || "-1"));
    });
  }

  handleKeyDown(event) {
    console.log("handleKeyDown", this.foundation_.handleKeyDown);
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
