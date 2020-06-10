/**
 * @license
 * Copyright 2019 Google Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import {MDCComponent} from '@material/base/component';
import {closest} from '@material/dom/ponyfill';
import {MDCDataTableAdapter} from '@material/data-table/adapter';
import {strings} from '@material/data-table/constants';
import {MDCDataTableFoundation} from '@material/data-table/foundation';

export class MDCDataTable extends MDCComponent<MDCDataTableFoundation> {
  static attachTo(root: Element): MDCDataTable {
    return new MDCDataTable(root);
  }

  initialize() {}

  initialSyncWithDOM() {
    this.layout();
  }

  /**
   * Re-initializes header row checkbox and row checkboxes when selectable rows are added or removed from table.
   */
  layout() {
    this.foundation_.layout();
  }

  /**
   * @return Returns array of row elements.
   */
  getRows(): Element[] {
    return this.foundation_.getRows();
  }

  /**
   * @return Returns array of selected row ids.
   */
  getSelectedRowIds(): Array<string|null> {
    return this.foundation_.getSelectedRowIds();
  }

  /**
   * Sets selected row ids. Overwrites previously selected rows.
   * @param rowIds Array of row ids that needs to be selected.
   */
  setSelectedRowIds(rowIds: string[]) {
    this.foundation_.setSelectedRowIds(rowIds);
  }

  destroy() {}

  private getHeaderRowCheckbox() {
    const checkboxEl = (this.root_.querySelector(strings.HEADER_ROW_CHECKBOX_SELECTOR) as HTMLElement);
    if (checkboxEl) {
      return (checkboxEl as any).checkbox_;
    }
    return undefined;
  }

  private getRowCheckboxList() {
    return this.foundation_
      .getRows()
      .map(checkboxEl => (checkboxEl as any).checkbox_)
      .filter(checkbox => !!checkbox);
  }

  getDefaultFoundation() {
    // DO NOT INLINE this variable. For backward compatibility, foundations take a Partial<MDCFooAdapter>.
    // To ensure we don't accidentally omit any methods, we need a separate, strongly typed adapter variable.
    // tslint:disable:object-literal-sort-keys Methods should be in the same order as the adapter interface.
    const adapter: MDCDataTableAdapter = {
      addClassAtRowIndex: () => undefined,
      getRowCount: () => this.getRows().length,
      getRowElements: () => [].slice.call(this.root_.querySelectorAll(strings.ROW_SELECTOR)),
      getRowIdAtIndex: (rowIndex: number) => this.getRows()[rowIndex].getAttribute(strings.DATA_ROW_ID_ATTR),
      getRowIndexByChildElement: (el: Element) => {
        return this.getRows().indexOf((closest(el, strings.ROW_SELECTOR) as HTMLElement));
      },
      getSelectedRowCount: () => this.root_.querySelectorAll(strings.ROW_SELECTED_SELECTOR).length,
      isCheckboxAtRowIndexChecked: (rowIndex: number) => this.getRowCheckboxList()[rowIndex].checked,
      isHeaderRowCheckboxChecked: () => this.getHeaderRowCheckbox().checked,
      isRowsSelectable: () => false,
      notifyRowSelectionChanged: () => undefined,
      notifySelectedAll: () => undefined,
      notifyUnselectedAll: () => undefined,
      registerHeaderRowCheckbox: () => undefined,
      registerRowCheckboxes: () => undefined,
      removeClassAtRowIndex: () => undefined,
      setAttributeAtRowIndex: () => undefined,
      setHeaderRowCheckboxChecked: () => undefined,
      setHeaderRowCheckboxIndeterminate: () => undefined,
      setRowCheckboxCheckedAtIndex: () => undefined,
    };
    return new MDCDataTableFoundation(adapter);
  }
}
