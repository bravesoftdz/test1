// vc10_gdi_test.cpp : �������̨Ӧ�ó������ڵ㡣
//

// vs2010��release�汾��������
// ������Releaseģʽ�µ��Եķ�����
// 1.������Ŀ���Ҽ� -> ����
// 2.c++ -> ���� -��������Ϣ��ʽ    ѡ  �������ݿ�(/Zi)��(/ZI), ע�⣺����ǿ�Ļ���ֻ��(Zi) //Ĭ�� Zi
// 3.c++ -> �Ż� -���Ż�            ѡ  ��ֹ��/Od�� //Ĭ�� O2
// 4.������ -������ -�����ɵ�����Ϣ ѡ  �� ��/DEBUG��

// Ҫ�� wx ��,���̱����� "ʹ�ö��ֽ��ַ���"

#include "stdafx.h"

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
#include <wx/wx.h>
#endif

#include <wx/treectrl.h>


int _tmain(int argc, _TCHAR* argv[])
{
	int i = 1;

	printf("%i", i);

	return 0;
}//

