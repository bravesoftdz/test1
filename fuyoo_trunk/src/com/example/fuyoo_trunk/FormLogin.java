package com.example.fuyoo_trunk;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsoluteLayout;
import android.widget.Button;
import apublic.Functions;
import android.content.*; //for Intent


//�½���¼����
public class FormLogin extends Activity 
{
	FormLogin _this;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        
        //setContentView(R.layout.activity_form_t1); return;
        
        ///*
        //--------------------------------------------------
        _this = this;
        //--------------------------------------------------
        //ȫ��,����ʾ����ͷ
        Functions.SetFullScreen(this);
        
        //
        //ȷ������Ĳ���
		AbsoluteLayout abslayout=new AbsoluteLayout (this);
        setContentView(abslayout);
        
        View temp = new View(this);

        temp.setId(1);

        //this.addView(temp);
        
        //����һ��button��ť
        Button btn1 = new Button(this);
        btn1.setText("this is a button2");
        btn1.setId(1);
        //ȷ������ؼ��Ĵ�С��λ��
        AbsoluteLayout.LayoutParams lp1 =
	        new AbsoluteLayout.LayoutParams(
		        ViewGroup.LayoutParams.WRAP_CONTENT,
		        ViewGroup.LayoutParams.WRAP_CONTENT,
		        0,100);
        abslayout.addView(btn1, lp1);
        
        //--------------------------------------------------
        //ע��,�����Ĭ�� xml �ļ����,�������Ķ�̬������ͻ��
        //setContentView(R.layout.activity_main);
        //*/
        
        //���ð�ť�¼�
        SetOnClick(btn1);
        
    }//
    
    
    //��ʲô��
    @Override
    public boolean onCreateOptionsMenu(Menu menu) 
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }//    
    
    //���ð�ť�¼�
    void SetOnClick(Button button)
    {
    	FormLogin tmp = this;
//    	button.setOnClickListener(new Button.OnClickListener() { //��׼ȷ��Ӧ����View.OnClickListener
//    	    public void onClick(View v)
//    	    {
//    	        //this.ShowLogin(); //no
//    	        //tmp.ShowLogin(); //no
//    	    	////_this.ShowLogin(); //yes
//    	    	
//    	    	Functions.ShowMessage("aaa", FormLogin.this);
//    	    }
//    	});    	
    	
    	//this.getWindow().getDecorView() ȡ activity �� ��ǰ view
    	//Functions.SetOnClick(button, this, getWindow().getDecorView(), "ShowLogin");
    	Functions.SetOnClick(button, "ShowLogin", this);
    	
    }//
    
    //
    public void ShowLogin()
    {
    	Functions.ShowMessage("bbb", FormLogin.this);
        //�½�һ��Intent���� 
//        Intent intent = new Intent();
//        intent.putExtra("name","LeiPei");    
//        //ָ��intentҪ��������
//        intent.setClass(Activity01.this, Activity02.class);
//        //����һ���µ�Activity
//        Activity01.this.startActivity(intent);
//        //�رյ�ǰ��Activity
//        Activity01.this.finish();
    	
    }//
    
    
}//


