package com.deppon.task.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.deppon.task.pojo.TbUserCopy;
import com.deppon.task.pojo.TbUserCopyExample;

public interface TbUserCopyMapper {
    int countByExample(TbUserCopyExample example);

    int deleteByExample(TbUserCopyExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TbUserCopy record);

    int insertSelective(TbUserCopy record);

    List<TbUserCopy> selectByExample(TbUserCopyExample example);

    TbUserCopy selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TbUserCopy record, @Param("example") TbUserCopyExample example);

    int updateByExample(@Param("record") TbUserCopy record, @Param("example") TbUserCopyExample example);

    int updateByPrimaryKeySelective(TbUserCopy record);

    int updateByPrimaryKey(TbUserCopy record);
}