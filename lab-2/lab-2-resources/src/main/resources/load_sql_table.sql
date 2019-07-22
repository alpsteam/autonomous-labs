
-- create work table to hold JSON data
create table json_work_table (id number, data clob, constraint jst_ch check (data is json));

-- insert JSON data into holding table
-- do this in SQLDeveloper and paste the contents of product-catalog.json into the bind variable pop-up
insert into json_work_table values (1, :json_data);

-- create catalog table
create table product_catalog (product_id number, parent_category_id number, category_id number, product_name varchar2(256), product_status varchar2(100),
    cost_price number, list_price number, min_price number, warranty_period_months number, external_url varchar2(256), twitter_tag varchar2(256));
    
-- parse JSON in holding table into relational form and insert into product catalog
insert   into product_catalog
select  jt.product_id, jt.parent_category_id, jt.category_id, jt.product_name, jt.product_status, jt.cost_price, 
        jt.list_price, jt.min_price, jt.warranty_period_months, jt.external_url, jt.twitter_tag
FROM    json_work_table jwt,
        json_table(jwt.data, '$.Products[*]'
        COLUMNS (   product_id PATH '$.PRODUCT_ID',
                    parent_category_id PATH '$.PARENT_CATEGORY_ID',
                    category_id PATH '$.CATEGORY_ID',
                    product_name PATH '$.PRODUCT_NAME',
                    product_status PATH '$.PRODUCT_STATUS',
                    cost_price PATH '$.COST_PRICE',
                    list_price PATH '$.LIST_PRICE',
                    min_price PATH '$.MIN_PRICE',
                    warranty_period_months PATH '$.WARRANTY_PERIOD_MONTHS',
                    external_url PATH '$.EXTERNAL_URL',
                    twitter_tag PATH '$.TWITTER_TAG'
        )) jt
WHERE   jwt.id = 1;

-- check the catalog
select * from product_catalog;

-- clean up temporary work table
drop table json_work_table;