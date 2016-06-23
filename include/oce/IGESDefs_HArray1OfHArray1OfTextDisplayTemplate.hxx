// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _IGESDefs_HArray1OfHArray1OfTextDisplayTemplate_HeaderFile
#define _IGESDefs_HArray1OfHArray1OfTextDisplayTemplate_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_IGESDefs_HArray1OfHArray1OfTextDisplayTemplate.hxx>

#include <TColStd_Array1OfTransient.hxx>
#include <MMgt_TShared.hxx>
#include <Handle_IGESGraph_HArray1OfTextDisplayTemplate.hxx>
#include <Standard_Integer.hxx>
class IGESGraph_HArray1OfTextDisplayTemplate;



class IGESDefs_HArray1OfHArray1OfTextDisplayTemplate : public MMgt_TShared
{

public:

  
  Standard_EXPORT IGESDefs_HArray1OfHArray1OfTextDisplayTemplate(const Standard_Integer low, const Standard_Integer up);
  
  Standard_EXPORT   Standard_Integer Lower()  const;
  
  Standard_EXPORT   Standard_Integer Upper()  const;
  
  Standard_EXPORT   Standard_Integer Length()  const;
  
  Standard_EXPORT   void SetValue (const Standard_Integer num, const Handle(IGESGraph_HArray1OfTextDisplayTemplate)& val) ;
  
  Standard_EXPORT   Handle(IGESGraph_HArray1OfTextDisplayTemplate) Value (const Standard_Integer num)  const;




  DEFINE_STANDARD_RTTI(IGESDefs_HArray1OfHArray1OfTextDisplayTemplate)

protected:




private: 


  TColStd_Array1OfTransient thelist;


};







#endif // _IGESDefs_HArray1OfHArray1OfTextDisplayTemplate_HeaderFile