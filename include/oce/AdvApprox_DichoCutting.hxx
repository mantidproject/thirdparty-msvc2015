// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _AdvApprox_DichoCutting_HeaderFile
#define _AdvApprox_DichoCutting_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <AdvApprox_Cutting.hxx>
#include <Standard_Boolean.hxx>
#include <Standard_Real.hxx>



//! if Cutting is necessary in [a,b], we cut at (a+b) / 2.
class AdvApprox_DichoCutting  : public AdvApprox_Cutting
{
public:

  DEFINE_STANDARD_ALLOC

  
  Standard_EXPORT AdvApprox_DichoCutting();
  
  Standard_EXPORT virtual   Standard_Boolean Value (const Standard_Real a, const Standard_Real b, Standard_Real& cuttingvalue)  const;




protected:





private:





};







#endif // _AdvApprox_DichoCutting_HeaderFile