package com.ctrip.framework.apollo.portal.repository;

import com.ctrip.framework.apollo.portal.entity.po.UTUserPO;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * @author lepdou 2017-04-08
 */
public interface UTUserRepository extends PagingAndSortingRepository<UTUserPO, Long> {





  UTUserPO findByUserId(String userId);

  List<UTUserPO> findByUserIdIn(List<String> userIds);
}
