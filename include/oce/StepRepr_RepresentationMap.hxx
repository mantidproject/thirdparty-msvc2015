// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _StepRepr_RepresentationMap_HeaderFile
#define _StepRepr_RepresentationMap_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_StepRepr_RepresentationMap.hxx>

#include <Handle_StepRepr_RepresentationItem.hxx>
#include <Handle_StepRepr_Representation.hxx>
#include <MMgt_TShared.hxx>
class StepRepr_RepresentationItem;
class StepRepr_Representation;



class StepRepr_RepresentationMap : public MMgt_TShared
{

public:

  
  //! Returns a RepresentationMap
  Standard_EXPORT StepRepr_RepresentationMap();
  
  Standard_EXPORT virtual   void Init (const Handle(StepRepr_RepresentationItem)& aMappingOrigin, const Handle(StepRepr_Representation)& aMappedRepresentation) ;
  
  Standard_EXPORT   void SetMappingOrigin (const Handle(StepRepr_RepresentationItem)& aMappingOrigin) ;
  
  Standard_EXPORT   Handle(StepRepr_RepresentationItem) MappingOrigin()  const;
  
  Standard_EXPORT   void SetMappedRepresentation (const Handle(StepRepr_Representation)& aMappedRepresentation) ;
  
  Standard_EXPORT   Handle(StepRepr_Representation) MappedRepresentation()  const;




  DEFINE_STANDARD_RTTI(StepRepr_RepresentationMap)

protected:




private: 


  Handle(StepRepr_RepresentationItem) mappingOrigin;
  Handle(StepRepr_Representation) mappedRepresentation;


};







#endif // _StepRepr_RepresentationMap_HeaderFile