// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _StepRepr_MaterialDesignation_HeaderFile
#define _StepRepr_MaterialDesignation_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_StepRepr_MaterialDesignation.hxx>

#include <Handle_TCollection_HAsciiString.hxx>
#include <StepRepr_CharacterizedDefinition.hxx>
#include <MMgt_TShared.hxx>
class TCollection_HAsciiString;
class StepRepr_CharacterizedDefinition;



class StepRepr_MaterialDesignation : public MMgt_TShared
{

public:

  
  Standard_EXPORT StepRepr_MaterialDesignation();
  
  Standard_EXPORT   void Init (const Handle(TCollection_HAsciiString)& aName, const StepRepr_CharacterizedDefinition& aOfDefinition) ;
  
  Standard_EXPORT   void SetName (const Handle(TCollection_HAsciiString)& aName) ;
  
  Standard_EXPORT   Handle(TCollection_HAsciiString) Name()  const;
  
  Standard_EXPORT   void SetOfDefinition (const StepRepr_CharacterizedDefinition& aOfDefinition) ;
  
  Standard_EXPORT   StepRepr_CharacterizedDefinition OfDefinition()  const;




  DEFINE_STANDARD_RTTI(StepRepr_MaterialDesignation)

protected:




private: 


  Handle(TCollection_HAsciiString) name;
  StepRepr_CharacterizedDefinition ofDefinition;


};







#endif // _StepRepr_MaterialDesignation_HeaderFile