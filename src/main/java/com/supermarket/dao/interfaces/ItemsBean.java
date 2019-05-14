package com.supermarket.dao.interfaces;

import com.supermarket.models.Items;

import java.util.List;

public interface ItemsBean {
    void addOrUpdateItem(Items item);
    void deleteItem(Items item);
    List<Items> itemsList();
    Items getItemByUniCode (int universalProductCode);
    Items getItemsById (Long id);
}
