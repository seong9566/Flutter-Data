package hyeonseong.shop.fserver;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactory;

public interface ProductRepository extends JpaRepository<Product, Integer> {

}
