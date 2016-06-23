// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d_HeaderFile
#define _Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d.hxx>

#include <Extrema_POnCurv2d.hxx>
#include <TCollection_SeqNode.hxx>
#include <TCollection_SeqNodePtr.hxx>
class Extrema_POnCurv2d;
class Extrema_SeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d;



class Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d : public TCollection_SeqNode
{

public:

  
    Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d(const Extrema_POnCurv2d& I, const TCollection_SeqNodePtr& n, const TCollection_SeqNodePtr& p);
  
      Extrema_POnCurv2d& Value()  const;




  DEFINE_STANDARD_RTTI(Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d)

protected:




private: 


  Extrema_POnCurv2d myValue;


};

#define SeqItem Extrema_POnCurv2d
#define SeqItem_hxx <Extrema_POnCurv2d.hxx>
#define TCollection_SequenceNode Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d
#define TCollection_SequenceNode_hxx <Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d.hxx>
#define Handle_TCollection_SequenceNode Handle_Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d
#define TCollection_SequenceNode_Type_() Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d_Type_()
#define TCollection_Sequence Extrema_SeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d
#define TCollection_Sequence_hxx <Extrema_SeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d.hxx>

#include <TCollection_SequenceNode.lxx>

#undef SeqItem
#undef SeqItem_hxx
#undef TCollection_SequenceNode
#undef TCollection_SequenceNode_hxx
#undef Handle_TCollection_SequenceNode
#undef TCollection_SequenceNode_Type_
#undef TCollection_Sequence
#undef TCollection_Sequence_hxx




#endif // _Extrema_SequenceNodeOfSeqPCOfPCFOfEPCOfELPCOfLocateExtPC2d_HeaderFile