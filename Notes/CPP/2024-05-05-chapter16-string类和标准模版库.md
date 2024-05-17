---
layout: post
author: "大西瓜"
title: "chapter16 string类和标准模版库"
date:   2024-05-05 15:45:09 +0800
categories: [update,CPP] 
---

## chapter16:string 类和标准模版库

## string 类

String 有很多构造函数

```c++
	1) string(const char *) 使用这个构造函数
	string one("Lottery winner");

	2) string(size_t n,char n)
	string two(20,'A');

	3) string(const string& s)   拷贝构造函数
	string three(one);

	4) string()   空字符串
	string four;


	5) string(char *start,size_t n)  拷贝 start 前 n 个字符
	char alls[]="!@#$%^&QWERTY";
	string fine(alls,20); //不严谨  打印结果 i am eendC+ 


	6) template<class Iter>  string(iter begin,iter end);  模版范围不包括 end  包括 
	string six(alls+1,alls+6);

	7 ）拷贝构造函数 string ,start_position, size  
	//string(const string &str,string size_type   
	//				 pos=0 , size_type n =npos);

	string eight(four,3,4);


	8) string(const && str) noexcept; //可以修改  c++ 11 


	9) string(initializer_list<char>i);
	string nine{'h','e','l','l','0'};  //c++11
```

查看分配的内存

```c++

	string st;
	st.capacity();  //查看分配的内存 单位字节
	st.reserve(100); // 重新分配100个字节 
```





## 智能指针模版类

**智能指针头文件<memory>**

⚠️**只删除指针，不能删除数组，必须得有名字 智能指向new新开辟的内存区域**

```c++
template<class T>
class auto_ptr{
private:
	T* _ptr;
public:																		//throw() 不抛错
	auto_ptr(T* arg=0)throw():_ptr(arg){}  // arg 参数默认为0 也可以 new T
	~auto_prt(){delete _ptr;}			//自动释放内存   头文件不这样写，方便自动看
}

//怎么用？

auto_prt<int> t1(new int);    //auto_prt<int> 是类名称


```



**auto-ptr ** c99 已经被弃用

**unique_ptr,shared_ptr**

模版类的对象 

	-会有析构函数自动释放

```c++
void demo(){
auto_ptr<double> ap(new double);
*ap=25.5;				//运行到代码块最后  auto_ptr<double> 类 会自动调用析构函数 释放内存
return ;
}
```

**三种智能指针都应该避免这种情况**

**智能指针一定要用new 开辟出来的空间**

```c++
string str("hello");
unique_ptr<string> ptr(&str);  //报错  不允许释放内存空间了
//析构函数 不允许释放str 所在的内存空间
cout << *ptr << endl;

⚠️ 也不允许 
string *pt= nullptr;
unique_ptr<string> ptr(pt); //初始化已经存在的指针
```

auto_ptr 为什么被弃用

```c++
auto_ptr<string> p2(string("hell"));
auto_ptr<string> p;
p=p2; //都指向 “hello”  试图删除 内存空间两次

解决方法:
			//应该使用深度复制 如果第一个不为NULL 再开辟一个内存空间 
			//交出所有权
			//share_tr 引用计数(reference counting ) 赋值的时候,计数器加1，过期的时候 计数器减1最后一个指针过去的时候，才调用delete
			//计数器默认为0,拷贝复制的时候，计数器加1，析构函数应该这样写,
			//if(cout !=0)
						count--;
				else
delete T;
```

**三种智能指针的区别**

```c++
	//auto_prt的用法:当p2 指向p1所指向的内存空间 p1的所有全被剥夺,不能使用
	//编译不回报错，运行的时候才报错
	auto_ptr<string> p1(new string("hello1"));
	autp_ptr<string> p2;
	p2=p1;

	//unique_ptr:计数器的初始值为0 每创建一个对象都会计数器+1
	//复制运算符里面  if 计数器 >1 throw() 直接报错 
	//编译直接报错，不会运行
	unique_ptr<string> p1(new string("hello1"));
	unique_ptr<string> p2;  
	p2=p1;

	//shared_ptr:计数器的初始值为0 每创建一个对象都会计数器+1
	//析构函数里面 if 计数器==1 delete ；计数器 --
	shared_ptr<string> p1(new string("hello1"));
	shared_ptr<string> p2;
	p2=p1;
```

```c++
unique_ptr<string> demo(const char* s){
unique_ptr<string> tmp(string(s));  //临时的右值，没有使用机会，编译器允许这样操作 离开作用域回被销毁
return temp;			//返回的指针其实上只是一个 地址；对象已经被销毁 
}		

unique_ptr<string> p;			//编译不回报错
p=demo("hello,kitty"); //定义的temp是个右值，并且离开函数定义的作用域已经被销毁

unique_ptr<string> pu1(new string("hello"));
unique_ptr<string> pu2;
pu2=pu1; // ⚠️ NOT ALLOW pu1 是右值，但是不是临时的 

unqie_ptr<string> pu3;
pu3=unqie_ptr<string>(new string("hello,kitty"));//⚠️ ALLOW 调用构造函数
													//创建临时对象 然后很快被赋值给pu3 然后临时对象回被销毁

当unique_ptr 重写赋值给另外一个 unique_ptr 的时候，可以用std::move() 方法 

using namespace std;
unique_ptr<string> p1,p2;
ps1=demo("helo,kieey");
ps2=move(ps1);	//把ps1 给解除了 重写赋予她一个新的功能 
ps1=demo("new argument");
cout <<*ps1 <<*ps << endl;

```



## 如何选择智能指针



```c++
auto_ptr; //尽量不用，编译不报错，运行才报错 离开作用域会被销毁.
如果要用多个指针指向同一个对象 应该使用 shared_ptr;
如果只用一个指针指向一个对象 应该用unique_ptr;

```



## 标准模版库



容器:

```c++
基本方法
size（）
swap（）
begin（）容器的第一个元素的迭代器
swap（）
end（） 最后一个加1 
	erase()  删除 两个参数 开始指针和最后指针
insert() 插入数据 三个参数 容器的开始位置,插入容器的开始指针，插入容器的结束指针
for_each(args);// container.begin() ,container.end(),function	
random_shuffle(); random_shuffle(XX.begin(),xx.end());

```

迭代器：

```c++ 
广义的指针 
可以重载operator*（） 
递增 operator++()

创建迭代器
vector<double>::iterator pd; 
		//or auto pd=pd.begin();
		//迭代器只是一个指针，可以指向容器里面的第一个元素 pd.begin  
		//也可以指向容器里面的最后一个元素
		//
```

**For_each**函数

```c++
#include <algorithm>
void ShowReview(const Review&r){
	cout << r.rating <<"\t"<< r.title << endl;
}

Vector<Review> data; //

for_each(data.begin(),data.end(),ShowReview);

```

**ramdon_shuffle**函数

```c++
#include <algorithm>
//随机排列顺序

int a[4]={1,2,3,4};
randon_shuffle(&a[0],&a[4]); 

//如果数据是容器；
struct SS{...}

vector<SS> Vs;

random_shuffle(Vs.begin(),Vs.end());  //打乱容器中的顺序
```

**sort**函数

```c++
#include <algorithm>

//基本数据类型

int arr[]={3,4,5,6,7,4};   
sort(&arr[0],&arr[5]);  //该数据类型已经支持 operator<(const int a1,const int a2)
for_each(&arr[0],&arr[5],[](int a){cout << a << " ";});

//如果数据类型不支持 bool operator<(const 该数据类型1，const 该数据类型2)
//需要自定义 参数为两个数据类型，并且返回值为bool的 函数
Struct SS{
string name;
int age;
};

bool MySortFunc(const SS s1,const SS s2){
if(s1.name < s2.name)
return true;
else if(s1.name ==s2.name && s1.age < s2.age)
return true;
else
return false;
}

vector<SS> Myss;
...各种操作之后。

//排序操作
sort(Myss.begin(),Myss.end(),MySortFunc) //第三个参数为自定义的比较函数








```


## 一元谓词二元谓词 仿函数

接受一个参数的叫做一元谓词

接受一个参数的叫做一元谓词

```c++
仿函数;
class FackFunc{
private:
	int value;
public:
	FackFunc(int n):value(n){}
	bool operator()(int others){
 return value > others;
}
}
FackFunc My(5); 

My(4) ; 			  // True;
FackFunc(4)(5);//false;
```







## 算法 algorithm



```c++
1	非修改时的  头文件 algorithm
2	修改			头文件 algorithm
3	排序			 头文件 algorithm
4 通用数字运算		numeric
```

```c++
#include <iostream>
#include <algorithm>

using namespace  std;

int main(){
string name;

cout <<"Enter the letter group:quit to quit:" << endl;

while(cin >> name && name !="quit"){
   sort(name.begin(),name.end());      //先进行顺序排列
   cout <<"Now the name:" << name << endl;

   while(next_permutation(name.begin(),name.end())){ //返回只要还可以进行排序就一直返回true
       cout <<  name  << " ";
   }
   cout << endl;
   cout <<"Enter the letter group:quit to quit:" << endl;
}
return 0;
}
```

## Algorithm 中的函数模板

| 名称                                                         | 说明                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`adjacent_find`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#adjacent_find) | 搜索相等或满足指定条件的两个相邻元素。                       |
| [`all_of`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#all_of) | 当给定范围中的每个元素均满足条件时返回 **`true`**。          |
| [`any_of`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#any_of) | 当指定元素范围中至少有一个元素满足条件时返回 **`true`**。    |
| [`binary_search`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#binary_search) | 测试已排序的范围中是否有等于指定值的元素，或在二元谓词指定的意义上与指定值等效的元素。 |
| [`clamp`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#clamp) |                                                              |
| [`copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#copy) | 将一个源范围中的元素值分配到目标范围，循环访问元素的源序列并将它们分配在一个向前方向的新位置。 |
| [`copy_backward`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#copy_backward) | 将一个源范围中的元素值分配到目标范围，循环访问元素的源序列并将它们分配在一个向后方向的新位置。 |
| [`copy_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#copy_if) | 复制给定范围中对于指定条件为 **`true`** 的所有元素。         |
| [`copy_n`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#copy_n) | 复制指定数量的元素。                                         |
| [`count`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#count) | 返回范围中其值与指定值匹配的元素的数量。                     |
| [`count_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#count_if) | 返回范围中其值与指定条件匹配的元素的数量。                   |
| [`equal`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#equal) | 逐个元素比较两个范围是否相等或是否在二元谓词指定的意义上等效。 |
| [`equal_range`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#equal_range) | 在排序的范围中查找符合以下条件的位置对：第一个位置小于或等效于指定元素的位置，第二个位置大于此元素位置，等效意义或用于在序列中建立位置的排序可通过二元谓词指定。 |
| [`fill`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#fill) | 将相同的新值分配给指定范围中的每个元素。                     |
| [`fill_n`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#fill_n) | 将新值分配给以特定元素开始的范围中的指定数量的元素。         |
| [`find`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#find) | 在范围中找到具有指定值的元素的第一个匹配项位置。             |
| [`find_end`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#find_end) | 在范围中查找与指定序列相同的最后一个序列，或在二元谓词指定的意义上等效的最后一个序列。 |
| [`find_first_of`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#find_first_of) | 在目标范围中搜索若干值中任意值的第一个匹配项，或搜索在二元谓词指定的意义上等效于指定元素集的若干元素中任意元素的第一个匹配项。 |
| [`find_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#find_if) | 在范围中找到满足指定条件的元素的第一个匹配项位置。           |
| [`find_if_not`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#find_if_not) | 返回指示的范围中不满足条件的第一个元素。                     |
| [`for_each`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#for_each) | 将指定的函数对象按向前顺序应用于范围中的每个元素并返回此函数对象。 |
| [`for_each_n`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#for_each_n) |                                                              |
| [`generate`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#generate) | 将函数对象生成的值分配给范围中的每个元素。                   |
| [`generate_n`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#generate_n) | 将函数对象生成的值分配给范围中指定数量的元素，并返回到超出最后一个分配值的下一位置。 |
| [`includes`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#includes) | 测试一个排序的范围是否包含另一排序范围中的所有元素，其中元素之间的排序或等效条件可通过二元谓词指定。 |
| [`inplace_merge`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#inplace_merge) | 将两个连续的排序范围中的元素合并为一个排序范围，其中排序条件可通过二元谓词指定。 |
| [`is_heap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#is_heap) | 如果指定范围中的元素形成堆，则返回 **`true`**。              |
| [`is_heap_until`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#is_heap_until) | 如果指定范围形成直到最后一个元素的堆，则返回 **`true`**。    |
| [`is_partitioned`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#is_partitioned) | 如果给定范围中对某个条件测试为 **`true`** 的所有元素在测试为 **`true`** 的所有元素之前，则返回 **`false`**。 |
| [`is_permutation`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#is_permutation) | 确定给定范围的元素是否形成有效排列。                         |
| [`is_sorted`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#is_sorted) | 如果指定范围中的元素按顺序排序，则返回 **`true`**。          |
| [`is_sorted_until`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#is_sorted_until) | 如果指定范围中的元素按顺序排序，则返回 **`true`**。          |
| [`iter_swap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#iter_swap) | 交换由一对指定迭代器引用的两个值。                           |
| [`lexicographical_compare`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#lexicographical_compare) | 逐个元素比较两个序列以确定其中的较小序列。                   |
| [`lower_bound`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#lower_bound) | 在排序的范围中查找其值大于或等效于指定值的第一个元素的位置，其中排序条件可通过二元谓词指定。 |
| [`make_heap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#make_heap) | 将指定范围中的元素转换到第一个元素是最大元素的堆中，其中排序条件可通过二元谓词指定。 |
| [`max`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#max) | 比较两个对象并返回较大对象，其中排序条件可通过二元谓词指定。 |
| [`max_element`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#max_element) | 在指定范围中查找最大元素的第一个匹配项，其中排序条件可通过二元谓词指定。 |
| [`merge`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#merge) | 将两个排序的源范围中的所有元素合并为一个排序的目标范围，其中排序条件可通过二元谓词指定。 |
| [`min`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#min) | 比较两个对象并返回较小对象，其中排序条件可通过二元谓词指定。 |
| [`min_element`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#min_element) | 在指定范围中查找最小元素的第一个匹配项，其中排序条件可通过二元谓词指定。 |
| [`minmax`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#minmax) | 比较两个输入参数，并按最小到最大的顺序将它们作为参数对返回。 |
| [`minmax_element`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#minmax_element) | 在一次调用中执行由 [`min_element`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#min_element) 和 [`max_element`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#max_element) 执行的操作。 |
| [`mismatch`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#mismatch) | 逐个元素比较两个范围是否相等或是否在二元谓词指定的意义上等效，并找到出现不同的第一个位置。 |
| [` move`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#alg_move) | 移动与指定范围关联的元素。                                   |
| [`move_backward`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#move_backward) | 将一个迭代器的元素移动到另一迭代器。 移动从指定范围的最后一个元素开始，并在此范围的第一个元素结束。 |
| [`next_permutation`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#next_permutation) | 重新排序范围中的元素，以便使用按字典顺序的下一个更大排列（如果有）替换原有排序，其中“下一个”的意义可通过二元谓词指定。 |
| [`none_of`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#none_of) | 当给定范围中没有元素满足条件时返回 **`true`**。              |
| [`nth_element`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#nth_element) | 对范围内的元素分区，正确找到范围中序列的第 *n* 个元素，以使序列中位于此元素之前的所有元素小于或等于此元素，位于此元素之后的所有元素大于或等于此元素。 |
| [`partial_sort`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#partial_sort) | 将范围中指定数量的较小元素按非降序顺序排列，或根据二元谓词指定的排序条件排列。 |
| [`partial_sort_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#partial_sort_copy) | 将源范围中的元素复制到目标范围，其中源元素按降序或二元谓词指定的其他顺序排序。 |
| [`partition`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#partition) | 将范围中的元素分为两个不相交的集，满足一元谓词的元素在不满足一元谓词的元素之前。 |
| [`partition_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#partition_copy) | 将条件为 **`true`** 的元素复制到一个目标，将条件为 **`false`** 的元素复制到另一目标。 元素必须来自于指定范围。 |
| [`partition_point`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#partition_point) | 返回给定范围中不满足条件的第一个元素。 元素经过排序，满足条件的元素在不满足条件的元素之前。 |
| [`pop_heap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#pop_heap) | 移除从堆顶到范围中倒数第二个位置之间的最大元素，然后将剩余元素形成新堆。 |
| [`prev_permutation`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#prev_permutation) | 重新排序范围中的元素，以便使用按字典顺序的下一个更大排列（如果有）替换原有排序，其中“下一个”的意义可通过二元谓词指定。 |
| [`push_heap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#push_heap) | 将范围末尾的元素添加到包括范围中前面元素的现有堆中。         |
| [`random_shuffle`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#random_shuffle) | 将范围中 *N* 个元素的序列重新排序为随机 *N*! 种序列中的 可能排列之一。 |
| [`remove`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#remove) | 从给定范围中消除指定值，而不影响剩余元素的顺序，并返回不包含指定值的新范围的末尾。 |
| [`remove_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#remove_copy) | 将源范围中的元素复制到目标范围（不复制具有指定值的元素），而不影响剩余元素的顺序，并返回新目标范围的末尾。 |
| [`remove_copy_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#remove_copy_if) | 将源范围中的元素复制到目标范围（不复制满足谓词的元素），而不影响剩余元素的顺序，并返回新目标范围的末尾。 |
| [`remove_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#remove_if) | 从给定范围中消除满足谓词的元素，而不影响剩余元素的顺序，并返回不包含指定值的新范围的末尾。 |
| [`replace`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#replace) | 检查范围中的每个元素，并替换与指定值匹配的元素。             |
| [`replace_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#replace_copy) | 检查源范围中的每个元素，并替换与指定值匹配的元素，同时将结果复制到新的目标范围。 |
| [`replace_copy_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#replace_copy_if) | 检查源范围中的每个元素，并替换满足指定谓词的元素，同时将结果复制到新的目标范围。 |
| [`replace_if`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#replace_if) | 检查范围中的每个元素，并替换满足指定谓词的元素。             |
| [`reverse`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#reverse) | 反转范围中元素的顺序。                                       |
| [`reverse_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#reverse_copy) | 反转源范围中元素的顺序，同时将这些元素复制到目标范围         |
| [`rotate`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#rotate) | 交换两个相邻范围中的元素。                                   |
| [`rotate_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#rotate_copy) | 交换源范围中两个相邻范围内的元素，并将结果复制到目标范围。   |
| [`sample`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#sample) |                                                              |
| [`search`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#search) | 在目标范围中搜索其元素与给定序列中的元素相等或在二元谓词指定的意义上等效于给定序列中的元素的序列的第一个匹配项。 |
| [`search_n`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#search_n) | 在范围中搜索具有特定值或按二元谓词的指定与此值相关的指定数量的元素。 |
| [`set_difference`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#set_difference) | 将属于一个排序的源范围、但不属于另一排序的源范围的所有元素相并到一个排序的目标范围，其中排序条件可通过二元谓词指定。 |
| [`set_intersection`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#set_intersection) | 将属于两个排序的源范围的所有元素相并为一个排序的目标范围，其中排序条件可通过二元谓词指定。 |
| [`set_symmetric_difference`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#set_symmetric_difference) | 将属于一个而不是两个排序的源范围的所有元素相并为一个排序的目标范围，其中排序条件可通过二元谓词指定。 |
| [`set_union`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#set_union) | 将至少属于两个排序的源范围之一的所有元素相并为一个排序的目标范围，其中排序条件可通过二元谓词指定。 |
| [`sort`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#sort) | 将指定范围中的元素按非降序顺序排列，或根据二元谓词指定的排序条件排列。 |
| [`shuffle`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#shuffle) | 使用随机数生成器重新排列给定范围中的元素。                   |
| [`sort_heap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#sort_heap) | 将堆转换为排序的范围。                                       |
| [`stable_partition`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#stable_partition) | 将范围中的元素分为两个不相交的集，满足一元谓词的元素在不满足一元谓词的元素之前，并保留等效元素的相对顺序。 |
| [`stable_sort`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#stable_sort) | 将指定范围中的元素按非降序顺序排列，或根据二元谓词指定的排序条件排列，并保留等效元素的相对顺序。 |
| [`swap`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#swap) | 在两种类型的对象之间交换元素值，将第一个对象的内容分配给第二个对象，将第二个对象的内容分配给第一个对象。 |
| [`swap_ranges`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#swap_ranges) | 将一个范围中的元素与另一大小相等的范围中的元素交换。         |
| [`transform`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#transform) | 将指定的函数对象应用于源范围中的每个元素或两个源范围中的元素对，并将函数对象的返回值复制到目标范围。 |
| [`unique`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#unique) | 移除指定范围中彼此相邻的重复元素。                           |
| [`unique_copy`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#unique_copy) | 将源范围中的元素复制到目标范围，彼此相邻的重复元素除外。     |
| [`upper_bound`](https://learn.microsoft.com/zh-cn/cpp/standard-library/algorithm-functions?view=msvc-170#upper_bound) | 在排序的范围中查找其值大于指定值的第一个元素的位置，其中排序条件可通过二元谓词指定。 |



## 	其他库



数组模版 vector，valarray，array

```
vector：自动调整大小

valarray :支持向量

```

slice 类

```c++
python 里面的slice ;

#include <valarray>

valarray<int> arr(10);

arr[slice(0,3,3)]=10;

arr value: [10 0 0 10 0 0 10 0 0 0]

slice(开始索引,取出的值，取多少个值);
slice 也属于一个类;
```

c++ 11 通用初始化语法:



```c++
std::vector<double>payment{45.77,34.66,34.55};

vector<type> 包含一个构造函数 initializer_list<type> 

{45.77,34.66,34.55} 作为 initializer_list<double> 

vector(initializer_list<value_type> __il);



```

Initializer_list

```c++
//需要包含头文件 < initializer_list >
#include<valarray>
#include<initializer_list>
#include <iostream>

using namespace std;

template<class T>
T sum(initializer_list<T> li){
	T value=0;
	for(auto p=li.begin();p!=li.end();p++)
		value +=*p;
	return value;
}

template<class T>
T average(initializer_list<T> li){
	return sum<T>(li)/(li.end() -li.begin());
	//显示调用 sum<T> 求和 除以 (迭代器尾减掉 迭代器头) 等于个数
}


int main(){
	initializer_list<double> b{4,4,8.6,0};
	cout << sum(b) << endl;
	cout << average(b) << endl;

	cout << average({3,4,5,6,8}) << endl;
	//隐式转换成 initializer_list<int>

	cout << average(initializer_list<double>{3.0,4,5,6,8}) << endl;
	//不知道参数为甚么类型，需要显示  3.0 与 int 类型






	return 0;
}
```





