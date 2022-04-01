# **Data Analysis for Retail : Sales Performance Report**

<img src="Sales Report Pic.jpg" style="width:100%"/>

<br/>

Project ini merupakan salah satu modul project-based yang telah saya selesaikan pada program yang diselenggarakan oleh Kementerian Komunikasi dan Informatika Republik Indonesia, yaitu Digital Talent Scholarship pelatihan Data Analyst Professional Academy yang bekerja sama dengan DQLab Academy. Pada project ini saya melakukan analisis terhadap performance dari DQLab Store dengan menggunakan MySQL.

<br/>

<hr>

## **Dataset Brief**

Dataset yang digunakan pada project kali ini berisi transaksi dari tahun 2009 sampai dengan tahun 2012 dengan jumlah raw data sebanyak 5500, termasuk di dalamnya order status yang terbagi menjadi order finished, order returned, dan order cancelled. 

Adapun dataset yang sudah diberikan dan akan digunakan pada project ini berisi data sebagai berikut :

<img src="Query Output 0.png" style="width:100%"/>

<br/>

<hr>

## **Project Task**
Dari data yang sudah diberikan, dari pihak manajemen DQLab store ingin mengetahui :
+ Overall performance DQLab Store dari tahun 2009–2012 untuk jumlah order dan total sales order finished.
+ Overall performance DQLab by subcategory product yang akan dibandingkan antara tahun 2011 dan tahun 2012.
+ Efektifitas dan efisiensi promosi yang dilakukan selama ini, dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan tahun.
+ Efektifitas dan efisiensi promosi yang dilakukan selama ini, dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan sub-category.
+ Analisa terhadap customer setiap tahunnya.

<br/>

<hr>

## **Data Processing**
### **A. Overall Performance by Year**

Dibuat Query dengan menggunakan SQL untuk mendapatkan total penjualan (sales) dan jumlah order (number_of_order) dari tahun 2009 sampai 2012 (years).
Pada Query ini digunakan filter dimana order_status = ‘Order Finished’ karena yang ingin diketahui adalah transaksi yang sudah selesai.

```SQL
SELECT 
YEAR(order_date) AS years, 
SUM(sales) AS sales, 
COUNT(order_quantity) AS number_of_order 
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date);

```

Adapun output yang dihasilkan adalah sebagai berikut :

<img src="Query output 1.png" style="width:25%"/>

<br/>

### B. **Overall Performance by Product Sub-category**

Dibuat Query dengan menggunakan SQL untuk mendapatkan total penjualan (sales) berdasarkan sub category dari produk (product_sub_category) pada tahun 2011 dan 2012 saja (years).

```SQL
SELECT
YEAR(order_date) AS years,
product_sub_category,
SUM(sales) AS sales
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
AND YEAR(order_date) BETWEEN 2011 AND 2012
GROUP BY years, product_sub_category
ORDER BY years, sales DESC;
```

Adapun sampel output yang dihasilkan adalah sebagai berikut :

<img src="Query Output 2.png" style="width:40%"/>

<br/>

### **C. Promotion Effectiveness and Efficiency by Years**

Pada bagian ini dilakukan analisa terhadap efektifitas dan efisiensi dari promosi yang sudah dilakukan selama ini. Efektifitas dan efisiensi dari promosi yang dilakukan akan dianalisa berdasarkan Burn Rate yaitu dengan membandingkan total value promosi yang dikeluarkan terhadap total sales yang diperoleh. DQLab Store berharap bahwa burn rate tetap berada di angka maskimum sebesar 4.5%.

```
Formula untuk burn rate : (total discount/total sales) * 100
```
Dibuat Derived Tables untuk menghitung total sales (sales) dan total discount (promotion_value) berdasarkan tahun(years) dan membuat formula untuk menghitung persentase burn rate nya (burn_rate_percentage).

```SQL
SELECT
YEAR(order_date) AS years,
SUM(sales) AS sales,
SUM(discount_value) AS promotion_value,
ROUND((SUM(discount_value)/SUM(sales))*100,2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years;
```
Adapun output yang dihasilkan adalah sebagai berikut :

<img src="Query Output 3.png" style="width:40%"/>

<br/>

### **D. Promotion Effectiveness and Efficiency by Product Sub-category**

Pada bagian ini dilakukan analisa terhadap efektifitas dan efisiensi dari promosi yang sudah dilakukan selama ini seperti pada bagian sebelumnya.

Akan tetapi, ada **kolom yang harus ditambahkan, yaitu : product_sub_category dan product_category**

```SQL
SELECT
YEAR(order_date) AS years,
product_sub_category,
product_category,
SUM(sales) AS sales,
SUM(discount_value) AS promotion_value,
ROUND((SUM(discount_value)/SUM(sales))*100,2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
AND YEAR(order_date) = 2012
GROUP BY 
years,
product_sub_category,
product_category
ORDER BY sales DESC;
```

Adapun output yang dihasilkan adalah sebagai berikut :

<img src="Query Output 4.png" style="width:50%"/>

<br/>

### **E. Customers Transactions per Year**

Dibuat Query untuk mengetahui jumlah customer (number_of_customer) yang bertransaksi setiap tahun dari 2009 sampai 2012 (years).

```SQL
SELECT
YEAR(order_date) AS years,
COUNT(DISTINCT customer) AS number_of_customer
FROM dqlab_sales_store
WHERE order_status = 'Order Finished ' AND YEAR(order_date) BETWEEN 2009 AND 2012
GROUP BY years
ORDER BY years ASC;
```

Adapun output yang dihasilkan adalah sebagai berikut :

<img src="Query Output 5.png" style="width:25%"/>

<br/>

<hr>

## **Conclusion**
+ Terjadi penurunan Overall Sales performance per tahun berdasarkan jumlah transaksi pada tahun 2011, namun jumlah transaksi meningkat kembali di tahun 2012. Sedangkan berdasarkan total sales, sempat terjadi penurunan pada tahun 2010, lalu kembali meningkat pada tahun selanjutnya.

+ Total penjualan tertinggi berdasarkan sub kategori produk untuk tahun 2011 diperoleh dari penjualan Chairs & Chairmats, yaitu sebesar 622,962,720. Sedangkan untuk penjualan tertinggi pada tahun 2012 diperoleh dari penjualan Office Machines, yaitu sebesar 811,427,140. Sementara itu penjualan tertinggi secara kumulatif untuk sepanjang tahun 2011–2012 diperoleh dari penjualan Office Machines dengan total penjualan sebesar 1,357,283,420.

+ Berdasarkan burn rate percentage, promosi yang dilakukan DQLab Store untuk tahun 2009–2012 kurang efektif dan efisien. Secara keseluruhan burn rate percentage yang dihasilkan tiap tahun masih belum memenuhi target maksimal burn rate yang ditetapkan DQLab Store yaitu sebesar 4.5%.

+ Jumlah customer yang melakukan transaksi untuk tahun 2009–2012 terjadi penurunan pada tahun 2011, lalu terjadi peningkatan kembali di tahun 2012. Secara keseluruhan tidak ada perubahan yang signifikan pada jumlah customer yang melakukan transaksi untuk tahun 2009–2012.
