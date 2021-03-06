// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _ShapeUpgrade_FaceDivideArea_HeaderFile
#define _ShapeUpgrade_FaceDivideArea_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_ShapeUpgrade_FaceDivideArea.hxx>

#include <Standard_Real.hxx>
#include <ShapeUpgrade_FaceDivide.hxx>
#include <Standard_Boolean.hxx>
class TopoDS_Face;


//! Divides face by max area criterium.
class ShapeUpgrade_FaceDivideArea : public ShapeUpgrade_FaceDivide
{

public:

  
  //! Creates empty  constructor.
  Standard_EXPORT ShapeUpgrade_FaceDivideArea();
  
  Standard_EXPORT ShapeUpgrade_FaceDivideArea(const TopoDS_Face& F);
  
  //! Performs splitting and computes the resulting shell
  //! The context is used to keep track of former splittings
  Standard_EXPORT virtual   Standard_Boolean Perform() ;
  
  //! Set max area allowed for faces
      Standard_Real& MaxArea() ;




  DEFINE_STANDARD_RTTI(ShapeUpgrade_FaceDivideArea)

protected:




private: 


  Standard_Real myMaxArea;


};


#include <ShapeUpgrade_FaceDivideArea.lxx>





#endif // _ShapeUpgrade_FaceDivideArea_HeaderFile
