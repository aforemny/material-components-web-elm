import { MDCList } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcList extends HTMLElement {

  get selectedIndex() {
    return this.selectedIndex_;
  }

  set selectedIndex(selectedIndex) {
    const previousSelectedIndex = this.selectedIndex_;
    this.selectedIndex_ = selectedIndex;
    if (!!this.list_) {
      this.list_.selectedIndex = selectedIndex;

      let previousIndex = (previousSelectedIndex.length > 0)
        ? previousSelectedIndex[0]
        : -1;

      if ((previousIndex !== -1) && !!this.list_.listElements[previousIndex]) {
        this.list_.listElements[previousIndex].setAttribute("tabindex", "-1");
      }

      if (selectedIndex.length > 0) {
        this.list_.listElements[selectedIndex[0]].setAttribute("tabindex", "0");
      } else {
        this.list_.listElements[0].setAttribute("tabindex", "0");
      }
    }
  }

  get vertical() {
    return this.vertical_;
  }

  set vertical(vertical) {
    this.vertical_ = vertical;
    if (!!this.list_) {
      this.list_.vertical = vertical;
    }
  }

  get wrapFocus() {
    return this.wrapFocus_;
  }

  set wrapFocus(wrapFocus) {
    this.wrapFocus_ = wrapFocus;
    if (!!this.list_) {
      this.list_.wrapFocus = wrapFocus;
    }
  }

  constructor() {
    super();
    this.selectedIndex_ = -1;
    this.wrapFocus_ = false;
    this.vertical_ = true;
    this.list_;
  }

  connectedCallback() {
    this.style.display = "block";
    installClassNameChangeHook.call(this);
    this.list_ = new MDCList(this);
    this.list_.selectedIndex = this.selectedIndex_;
    this.list_.vertical = this.vertical_;
    this.list_.wrapFocus = this.wrapFocus_;

    const firstSelectedListItem =
      this.querySelector(".mdc-list-item--selected, .mdc-list-item--activated");
    if (!!firstSelectedListItem) {
      firstSelectedListItem.setAttribute("tabindex", 0);
    } else {
      const firstListItem = this.querySelector(".mdc-list-item");
      if (!!firstListItem) {
        firstListItem.setAttribute("tabindex", 0);
      }
    }
  }

  disconnectedCallback() {
    this.list_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-list", MdcList);
