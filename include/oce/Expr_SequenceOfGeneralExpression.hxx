// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _Expr_SequenceOfGeneralExpression_HeaderFile
#define _Expr_SequenceOfGeneralExpression_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <TCollection_BaseSequence.hxx>
#include <Handle_Expr_GeneralExpression.hxx>
#include <Handle_Expr_SequenceNodeOfSequenceOfGeneralExpression.hxx>
#include <Standard_Integer.hxx>
class Standard_NoSuchObject;
class Standard_OutOfRange;
class Expr_GeneralExpression;
class Expr_SequenceNodeOfSequenceOfGeneralExpression;



class Expr_SequenceOfGeneralExpression  : public TCollection_BaseSequence
{
public:

  DEFINE_STANDARD_ALLOC

  
    Expr_SequenceOfGeneralExpression();
  
  Standard_EXPORT Expr_SequenceOfGeneralExpression(const Expr_SequenceOfGeneralExpression& Other);
  
  Standard_EXPORT   void Clear() ;
~Expr_SequenceOfGeneralExpression()
{
  Clear();
}
  
  Standard_EXPORT  const  Expr_SequenceOfGeneralExpression& Assign (const Expr_SequenceOfGeneralExpression& Other) ;
 const  Expr_SequenceOfGeneralExpression& operator = (const Expr_SequenceOfGeneralExpression& Other) 
{
  return Assign(Other);
}
  
  Standard_EXPORT   void Append (const Handle(Expr_GeneralExpression)& T) ;
  
      void Append (Expr_SequenceOfGeneralExpression& S) ;
  
  Standard_EXPORT   void Prepend (const Handle(Expr_GeneralExpression)& T) ;
  
      void Prepend (Expr_SequenceOfGeneralExpression& S) ;
  
      void InsertBefore (const Standard_Integer Index, const Handle(Expr_GeneralExpression)& T) ;
  
      void InsertBefore (const Standard_Integer Index, Expr_SequenceOfGeneralExpression& S) ;
  
  Standard_EXPORT   void InsertAfter (const Standard_Integer Index, const Handle(Expr_GeneralExpression)& T) ;
  
      void InsertAfter (const Standard_Integer Index, Expr_SequenceOfGeneralExpression& S) ;
  
  Standard_EXPORT  const  Handle(Expr_GeneralExpression)& First()  const;
  
  Standard_EXPORT  const  Handle(Expr_GeneralExpression)& Last()  const;
  
      void Split (const Standard_Integer Index, Expr_SequenceOfGeneralExpression& Sub) ;
  
  Standard_EXPORT  const  Handle(Expr_GeneralExpression)& Value (const Standard_Integer Index)  const;
 const  Handle(Expr_GeneralExpression)& operator() (const Standard_Integer Index)  const
{
  return Value(Index);
}
  
  Standard_EXPORT   void SetValue (const Standard_Integer Index, const Handle(Expr_GeneralExpression)& I) ;
  
  Standard_EXPORT   Handle(Expr_GeneralExpression)& ChangeValue (const Standard_Integer Index) ;
  Handle(Expr_GeneralExpression)& operator() (const Standard_Integer Index) 
{
  return ChangeValue(Index);
}
  
  Standard_EXPORT   void Remove (const Standard_Integer Index) ;
  
  Standard_EXPORT   void Remove (const Standard_Integer FromIndex, const Standard_Integer ToIndex) ;




protected:





private:





};

#define SeqItem Handle(Expr_GeneralExpression)
#define SeqItem_hxx <Expr_GeneralExpression.hxx>
#define TCollection_SequenceNode Expr_SequenceNodeOfSequenceOfGeneralExpression
#define TCollection_SequenceNode_hxx <Expr_SequenceNodeOfSequenceOfGeneralExpression.hxx>
#define Handle_TCollection_SequenceNode Handle_Expr_SequenceNodeOfSequenceOfGeneralExpression
#define TCollection_SequenceNode_Type_() Expr_SequenceNodeOfSequenceOfGeneralExpression_Type_()
#define TCollection_Sequence Expr_SequenceOfGeneralExpression
#define TCollection_Sequence_hxx <Expr_SequenceOfGeneralExpression.hxx>

#include <TCollection_Sequence.lxx>

#undef SeqItem
#undef SeqItem_hxx
#undef TCollection_SequenceNode
#undef TCollection_SequenceNode_hxx
#undef Handle_TCollection_SequenceNode
#undef TCollection_SequenceNode_Type_
#undef TCollection_Sequence
#undef TCollection_Sequence_hxx




#endif // _Expr_SequenceOfGeneralExpression_HeaderFile