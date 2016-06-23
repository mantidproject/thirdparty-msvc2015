// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _StepBasic_Action_HeaderFile
#define _StepBasic_Action_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_StepBasic_Action.hxx>

#include <Handle_TCollection_HAsciiString.hxx>
#include <Handle_StepBasic_ActionMethod.hxx>
#include <Standard_Boolean.hxx>
#include <MMgt_TShared.hxx>
class TCollection_HAsciiString;
class StepBasic_ActionMethod;


//! Representation of STEP entity Action
class StepBasic_Action : public MMgt_TShared
{

public:

  
  //! Empty constructor
  Standard_EXPORT StepBasic_Action();
  
  //! Initialize all fields (own and inherited)
  Standard_EXPORT   void Init (const Handle(TCollection_HAsciiString)& aName, const Standard_Boolean hasDescription, const Handle(TCollection_HAsciiString)& aDescription, const Handle(StepBasic_ActionMethod)& aChosenMethod) ;
  
  //! Returns field Name
  Standard_EXPORT   Handle(TCollection_HAsciiString) Name()  const;
  
  //! Set field Name
  Standard_EXPORT   void SetName (const Handle(TCollection_HAsciiString)& Name) ;
  
  //! Returns field Description
  Standard_EXPORT   Handle(TCollection_HAsciiString) Description()  const;
  
  //! Set field Description
  Standard_EXPORT   void SetDescription (const Handle(TCollection_HAsciiString)& Description) ;
  
  //! Returns True if optional field Description is defined
  Standard_EXPORT   Standard_Boolean HasDescription()  const;
  
  //! Returns field ChosenMethod
  Standard_EXPORT   Handle(StepBasic_ActionMethod) ChosenMethod()  const;
  
  //! Set field ChosenMethod
  Standard_EXPORT   void SetChosenMethod (const Handle(StepBasic_ActionMethod)& ChosenMethod) ;




  DEFINE_STANDARD_RTTI(StepBasic_Action)

protected:




private: 


  Handle(TCollection_HAsciiString) theName;
  Handle(TCollection_HAsciiString) theDescription;
  Handle(StepBasic_ActionMethod) theChosenMethod;
  Standard_Boolean defDescription;


};







#endif // _StepBasic_Action_HeaderFile