// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _Plate_LineConstraint_HeaderFile
#define _Plate_LineConstraint_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <Plate_LinearScalarConstraint.hxx>
#include <Standard_Integer.hxx>
class gp_XY;
class gp_Lin;
class Plate_LinearScalarConstraint;


//! constraint a point to belong to a straight line
class Plate_LineConstraint 
{
public:

  DEFINE_STANDARD_ALLOC

  
  Standard_EXPORT Plate_LineConstraint(const gp_XY& point2d, const gp_Lin& lin, const Standard_Integer iu = 0, const Standard_Integer iv = 0);
  
     const  Plate_LinearScalarConstraint& LSC()  const;




protected:





private:



  Plate_LinearScalarConstraint myLSC;


};


#include <Plate_LineConstraint.lxx>





#endif // _Plate_LineConstraint_HeaderFile
