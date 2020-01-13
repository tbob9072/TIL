# Pandas

> - 1 차원 : Series
> - 2 차원 : Data frame
> - 3 차원 : pannel

## 1. Series

```python
seq_data = [10, 20, 30, 40, 50]
seq_data
>>> [10, 20, 30, 40, 50]

s1 = pd.Series(seq_data)
s1
0    10
1    20
2    30
3    40
4    50
dtype: int64

# index 확인하기
s1.index
list(s1.index)
>>> [0, 1, 2, 3, 4]

#value 확인하기
s2.values
list(s2.values)
>>> ['a', 'b', 4.5]


# index 바꾸기
index_sq = ['2020-01-01', '2020-01-02', '2020-01-03', '2020-01-04', '2020-01-05',]
s3 = pd.Series(seq_data, index=index_sq)
s3

2020-01-01    10
2020-01-02    20
2020-01-03    30
2020-01-04    40
2020-01-05    50
dtype: int64

# index 바꾸기 2
index_sq2 = pd.date_range(start = "2020-01-03", end = '2020-01-07')
s4 = pd.Series(seq_data, index = index_sq2)
s4

2020-01-03    10
2020-01-04    20
2020-01-05    30
2020-01-06    40
2020-01-07    50
Freq: D, dtype: int64
```



## 2. Data frame

