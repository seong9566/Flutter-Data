package hyeonseong.shop.fserver;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@CrossOrigin
@RestController
public class ProductController {

    private final ProductRepository productRepository;

    @GetMapping("/api/product")
    public ResponseDto<?> findAll() {
        // try {
        // Thread.sleep(5000);// 화면에 5초간의 딜레이 주기 위함
        // } catch (Exception e) {

        // }
        return new ResponseDto<>(1, "전체 찾기 성공", productRepository.findAll());
    }

    @GetMapping("/api/product/{id}")
    public ResponseDto<?> findById(@PathVariable Integer id) {
        return new ResponseDto<>(1, "한건 찾기 성공", productRepository.findById(id).get());
    }

    @PostMapping("/api/product")
    public ResponseDto<?> insert(@RequestBody Product product) {
        product.setId(null);
        return new ResponseDto<>(1, "추가 성공", productRepository.save(product));
    }

    @PutMapping("/api/product/{id}")
    public ResponseDto<?> updateById(@PathVariable Integer id, @RequestBody Product product) {
        product.setId(id);
        return new ResponseDto<>(1, "수정 성공", productRepository.save(product));
    }

    @DeleteMapping("/api/product/{id}")
    public ResponseDto<?> deleteById(@PathVariable Integer id) {
        productRepository.deleteById(id);
        return new ResponseDto<>(1, "삭제 성공", null);
    }
}